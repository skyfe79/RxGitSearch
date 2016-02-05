//
//  SearchRepositoryResponse.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//

import ObjectMapper

class SearchRepositoryResponse: SearchResponseBase {
    
    var items : [RepositoryItem]
    
    required init?(_ map: Map) {
        items = [RepositoryItem]()
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        items <- map["items"]
    }
}
