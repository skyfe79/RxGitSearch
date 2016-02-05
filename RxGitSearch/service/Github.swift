//
//  GitHub.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift
import RxCocoa

enum SearchWhere {
    case REPOSITORY
    case CODE
    case ISSUE
    case USER
}


final class Github<T: Mappable> {
    
    static func rx_search(searchWhere: SearchWhere, what: String) -> Observable<T> {
        
        let parameter = SearchParameter.Builder()
            .query(what)
            .sort(.STARS)
            .order(.DESC)
            .build()
        
        return rx_search(searchWhere, parameter: parameter)
    }

    
    static func rx_search(searchWhere: SearchWhere, parameter: SearchParameter) -> Observable<T> {
        
        return Observable.create { subscriber -> Disposable in
            
            let request = self.search(searchWhere, parameter: parameter)
                .responseString(completionHandler: { (response) -> Void in
                    print(response.result.value ?? "NOT")
                })
                .responseObject({ (response : Response<T, NSError>) -> Void in
                    switch response.result {
                    case .Success(let value):
                        subscriber.onNext(value)
                        subscriber.onCompleted()
                    case .Failure(let error):
                        subscriber.onError(error)
                    }
                })
            
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
    
    
    static func search(searchWhere: SearchWhere, what: String) -> Request {
        let parameter = SearchParameter.Builder()
                                    .query(what)
                                    .sort(.STARS)
                                    .order(.DESC)
                                    .build()
        return self.search(searchWhere, parameter: parameter)
    }
    
    static func search(searchWhere: SearchWhere, parameter: SearchParameter) -> Request {
        
        let search : Search
        switch searchWhere {
        case .REPOSITORY:
            search = Search.Repository(param: parameter)
        case .ISSUE:
            search = Search.Issue(param: parameter)
        case .CODE:
            search = Search.Code(param: parameter)
        case .USER:
            search = Search.User(param: parameter)
        }
        
        let request = Alamofire.request(search)
        return request
    }
}
