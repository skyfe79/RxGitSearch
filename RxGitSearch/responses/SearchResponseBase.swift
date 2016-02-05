//
//  SearchResponseBase.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//

import ObjectMapper

class SearchResponseBase : Mappable {
    var totalCount : Int
    var isIncompleteResults : Bool
    
    required init?(_ map: Map) {
        totalCount = 0
        isIncompleteResults = false
    }
    
    func mapping(map: Map) {
        totalCount <- map["total_count"]
        isIncompleteResults <- map["incomplete_results"]
    }
}
