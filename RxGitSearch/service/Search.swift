//
//  SearchRepository.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import Alamofire

enum Search : URLRequestConvertible {

    static let SEARCH_BASE_URL = "https://api.github.com"
    
    case Repository(param: SearchParameter)
    case Code(param: SearchParameter)
    case Issue(param: SearchParameter)
    case User(param: SearchParameter)
    
    var method: Alamofire.Method {
        switch self {
        case .Repository, Code, Issue, User:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Repository:
            return "/search/repositories"
        case .Code:
            return "/search/code"
        case .Issue:
            return "/search/issues"
        case .User:
            return "/search/users"
        }
    }
    
    //MARK:- URLRequestConvertible 
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: Search.SEARCH_BASE_URL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .Repository(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters.params).0
        case .Code(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters.params).0
        case .Issue(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters.params).0
        case .User(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters.params).0
        }
    }
}
