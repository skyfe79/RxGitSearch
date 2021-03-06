//
//  SearchResponseBase.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

class SearchResponseBase : Mappable {
    var totalCount : Int
    var isIncompleteResults : Bool

    var apiRateLimitMessage : String? = nil
    
    required init?(_ map: Map) {
        totalCount = 0
        isIncompleteResults = false
    }
    
    func mapping(map: Map) {
        totalCount <- map["total_count"]
        isIncompleteResults <- map["incomplete_results"]
        apiRateLimitMessage <- map["message"]
    }
    
    func isApiRateLimited() -> Bool {
        return apiRateLimitMessage != nil
    }
}
