//
//  Route.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 6..
//  Copyright © 2016년 burt. All rights reserved.
//
//  This costomized version of SwiftRoute. @see https://github.com/skyline75489/SwiftRouter
//  I have to write this Route module because we need to use ViewModel and Back Route Block to remove dependency!

import Foundation
import UIKit

typealias BackRouteHandler = ((vc: UIViewController, result: Any?) -> Void)


class RouteEntry {
    
    var routePattern: String!
    var classVC: AnyClass!
    var parameter : [String:String] = [String:String]() // URL로 전달하는 값은 모두 String 이다.
    var backRouteHandler : BackRouteHandler? = nil
    
    init(routePattern: String, classVC: AnyClass) {
        self.routePattern = routePattern
        self.classVC = classVC
    }
    
    func setBackRouteHandler(back: BackRouteHandler) {
        self.backRouteHandler = back
    }
    
}

class Route {
    
    private static let kRouteEntryKey = "::entry::"
    private static var routeMap = NSMutableDictionary()
    private static var storyBoardName : String? = nil
    private static var pushedStoryBoardName : String? = nil
    
    static func setStoryBoardName(name: String) {
        storyBoardName = name
    }
    
    /**
        How to use?
     
        Route.pushStoryBoard("SomethingNewStoryBoard")
            Route.push(vc, "app://repository/detail/1")
        Route.popStoryBoard()
    */
    static func pushStoryBoard(newStoryBoardName: String) {
        pushedStoryBoardName = storyBoardName
        storyBoardName = newStoryBoardName
    }
    
    static func popStoryBoard() {
        storyBoardName = pushedStoryBoardName
        pushedStoryBoardName = nil
    }
    
    static func map(url: String, classVC: AnyClass) {
        let route = stripoffURLScheme(url)
        let pathComponents = pathComponentsInRoute(route)
        insertRoute(pathComponents, entry: RouteEntry(routePattern: route, classVC: classVC), subRoutes: self.routeMap)
    }
    
    static func push(fromVC : UIViewController, url: String, animated: Bool = true, useStoryBoard: Bool = true, onBack: BackRouteHandler? = nil) {
        
        if let back = onBack {
            updateBackRouteHandlerOfRouteEntry(url, back: back)
        }
        
        if useStoryBoard {
            
            if let vc = matchControllerFromStoryboard(url, storyboardName: storyBoardName!) {
                fromVC.navigationController?.pushViewController(vc, animated: animated)
            }
            
            
        } else {
            if let vc = matchController(url) {
                fromVC.navigationController?.pushViewController(vc, animated: animated)
            }
        }
        
    }
    
    static func present(fromVC : UIViewController, url: String, animated: Bool = true, useStoryBoard: Bool = true, onBack: BackRouteHandler? = nil) {
        if let back = onBack {
            updateBackRouteHandlerOfRouteEntry(url, back: back)
        }
        
        if useStoryBoard {
            
            if let vc = matchControllerFromStoryboard(url, storyboardName: storyBoardName!) {
                fromVC.presentViewController(vc, animated: animated, completion: nil)
            }
            
            
        } else {
            if let vc = matchController(url) {
                fromVC.presentViewController(vc, animated: animated, completion: nil)
            }
        }
        
        
    }
    
    static func custom(fromVC : UIViewController, url: String, animated: Bool = true, useStoryBoard: Bool = true, onBack: BackRouteHandler? = nil) {
        if let back = onBack {
            updateBackRouteHandlerOfRouteEntry(url, back: back)
        }
//        if useStoryBoard {
//            
//            if let vc = matchControllerFromStoryboard(url, storyboardName: storyBoardName!) {
//            }
//            
//            
//        } else {
//            if let vc = matchController(url) {
//            }
//        }
    }
    
    // back("http://repository/detail/:id", from: self, result: result)
    static func back(url: String, from: UIViewController, result: Any? = nil) {
        let route = stripoffURLScheme(url)
        var params = parametersInRoute(route)
        if let entry = findRouteEntry(route, params: &params) {
            if let back = entry.backRouteHandler {
                back(vc: from, result: result)
            }
        }
    }
}

extension Route {
    
    // app://user/detail/:id?name=:name&age=:age
    // app://user/detail/1?name=kim&age=30 -> UserDetailViewController를 찾아야 한다.
    
    private static func insertRoute(pathComponents: [String], entry: RouteEntry, subRoutes: NSMutableDictionary, index: Int = 0){
        
        let pathComponent = pathComponents[index]
        if subRoutes[pathComponent] == nil {
            if pathComponent == pathComponents.last {
                subRoutes[pathComponent] = NSMutableDictionary(dictionary: [kRouteEntryKey: entry])
                return
            }
            subRoutes[pathComponent] = NSMutableDictionary()
        }
        // recursive
        self.insertRoute(pathComponents, entry: entry, subRoutes: subRoutes[pathComponent] as! NSMutableDictionary, index: index+1)
    }
    
    private static func updateBackRouteHandlerOfRouteEntry(url: String, back: BackRouteHandler) {
        let route = stripoffURLScheme(url)
        var params = parametersInRoute(route)
        if let entry = findRouteEntry(route, params: &params) {
            entry.setBackRouteHandler(back)
        }
    }
    
    private static func matchController(url: String) -> UIViewController? {
        let route = stripoffURLScheme(url)
        var params = parametersInRoute(route)
        if let entry = findRouteEntry(route, params: &params) {
            let name = NSStringFromClass(entry.classVC!)
            var modelName = name
            // *****
            // force to use ViewModel!
            // 1. remove Controller from ViewController name
            // 2. append Model 
            // 3. instantiate
            // 4. set parameters
            modelName.removeRange(modelName.rangeOfString("Controller")!)
            modelName = modelName + "Model"
            let vcCLZ = NSClassFromString(name) as! NSObject.Type
            let vmCLZ = NSClassFromString(modelName) as! NSObject.Type
            let vcInstance = vcCLZ.init()
            let vmInstance = vmCLZ.init()
            vmInstance.setValuesForKeysWithDictionary(params)
            let routableVC = vcInstance as! RoutableViewController
            routableVC.setViewModel(vmInstance as! ViewModelType) // Injection
            return (vcInstance as! UIViewController)
        }
        return nil;
    }
    
    private static func matchControllerFromStoryboard(url: String, storyboardName: String) -> UIViewController? {
        let route = stripoffURLScheme(url)
        var params = parametersInRoute(route)
        if let entry = findRouteEntry(route, params: &params) {
            let name = NSStringFromClass(entry.classVC!)
            
            var modelName = name
            // *****
            // force to use ViewModel!
            // 1. remove Controller from ViewController name
            // 2. append Model
            // 3. instantiate
            // 4. set parameters
            modelName.removeRange(modelName.rangeOfString("Controller")!)
            modelName = modelName + "Model"
            let vcCLZ = NSClassFromString(name) as! NSObject.Type
            let vmCLZ = NSClassFromString(modelName) as! NSObject.Type
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle(forClass: vcCLZ))

            // You should use same name between VC Class Name and Storyboard Identifier
            let controllerIdentifier = name.componentsSeparatedByString(".").last!
            let vcInstance = storyboard.instantiateViewControllerWithIdentifier(controllerIdentifier)
            let vmInstance = vmCLZ.init()
            
            vmInstance.setValuesForKeysWithDictionary(params)
            let routableVC = vcInstance as! RoutableViewController
            routableVC.setViewModel(vmInstance as! ViewModelType) // Injection
            return vcInstance
        }
        return nil;
    }
    

    
    private static func parametersInRoute(route: String) -> [String: String] {
        
        var params = [String:String]()
        self.findRouteEntry(route, params: &params)
        
        if  let loc = route.rangeOfString("?") {
            let paramsString = route.substringFromIndex(loc.startIndex.advancedBy(1))
            let paramArray = paramsString.componentsSeparatedByString("&")
            for param in paramArray {
                let kv = param.componentsSeparatedByString("=")
                let k = kv[0]
                let v = kv[1]
                params[k] = v
            }
        }
        return params
    }
    
    private static func findRouteEntry(route: String, inout params:[String:String]) -> RouteEntry? {
        let pathComponents = pathComponentsInRoute(route)
        
        var subRoutes = self.routeMap
        for pathComponent in pathComponents {
            for (k, v) in subRoutes {
                // match handler first
                if subRoutes[pathComponent] != nil {
                    if pathComponent == pathComponents.last {
                        let d = subRoutes[pathComponent] as! NSMutableDictionary
                        let entry = d[kRouteEntryKey] as! RouteEntry
                        return entry
                    }
                    subRoutes = subRoutes[pathComponent] as! NSMutableDictionary
                    break
                }
                if k.hasPrefix(":") {
                    let s = String(k)
                    let key = s.substringFromIndex(s.startIndex.advancedBy(1))
                    params[key] = pathComponent
                    if pathComponent == pathComponents.last {
                        return v[kRouteEntryKey] as? RouteEntry
                    }
                    subRoutes = subRoutes[s] as! NSMutableDictionary
                    break
                }
            }
        }
        return nil
    }
    
    private static func pathComponentsInRoute(route: String) -> [String] {
        var path:NSString = NSString(string: route)
        if let loc = route.rangeOfString("?") {
            path = NSString(string: route.substringToIndex(loc.startIndex))
        }
        var result = [String]()
        for pathComponent in path.pathComponents {
            if pathComponent == "/" {
                continue
            }
            result.append(pathComponent)
        }
        return result
    }
    
    private static func stripoffURLScheme(url: String) -> String {
        let components = url.componentsSeparatedByString("://")
        if components.count == 2 {
            return "/" + components[1] // return /user/detail/1?name=kim&age=30
        }
        return url
    }
}
