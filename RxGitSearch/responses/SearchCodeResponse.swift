//
//  SearchCodeResponse.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

class SearchCodeResponse: SearchResponseBase {
    
    var items : [Code]
    
    required init?(_ map: Map) {
        items = [Code]()
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        items <- map["items"]
    }
}
