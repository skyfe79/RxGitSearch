//
//  GitHub.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

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


final class GithubService<T: SearchResponseBase> {
    
    private init() {}
    
    static func rx_search(searchWhere: SearchWhere, what: String, repository: String? = nil, language: String? = nil) -> Observable<T> {
        
        let parameter = SearchParameter.Builder()
            .query(what)
            .language(language)
            .repository(repository)
            .sort(.STARS)
            .order(.DESC)
            .build()
        
        return rx_search(searchWhere, parameter: parameter)
    }

    
    static func rx_search(searchWhere: SearchWhere, parameter: SearchParameter) -> Observable<T> {
        
        return Observable.create { subscriber -> Disposable in
            
            let request = self.search(searchWhere, parameter: parameter)
                .responseString(completionHandler: { (response : Response<String, NSError>) -> Void in
                    if let result = response.result.value {
                        //print(result)
                    } else {
                        subscriber.onError(NSError(domain: "There is no results", code: 1000, userInfo: nil))
                    }
                })
                .responseObject({ (response : Response<T, NSError>) -> Void in
                    switch response.result {
                    case .Success(let value):
                        if value.isApiRateLimited() {
                            subscriber.onError(NSError(domain: value.apiRateLimitMessage!, code: -1, userInfo: nil))
                        } else {
                            subscriber.onNext(value)
                            subscriber.onCompleted()
                        }
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
