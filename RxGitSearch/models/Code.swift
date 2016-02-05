//
//  CodeItem.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

struct Code : Mappable {
    var name: String? = nil
    var path: String? = nil
    var sha: String? = nil
    var url: String? = nil
    var gitURL: String? = nil
    var htmlURL: String? = nil
    var repository: Repository? = nil
    var score: Double = 0.0
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        path <- map["path"]
        sha <- map["sha"]
        url <- map["url"]
        gitURL <- map["git_url"]
        htmlURL <- map["html_url"]
        repository <- map["repository"]
        score <- map["score"]
    }
    
}
