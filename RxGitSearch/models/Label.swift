//
//  Label.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

struct Label : Mappable {
    
    var url: String? = nil
    var name: String? = nil
    var color: String? = nil
    
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        url <- map["url"]
        name <- map["name"]
        color <- map["color"]
    }
}
