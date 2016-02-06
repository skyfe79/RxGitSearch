//
//  PullRequest.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79



import ObjectMapper

struct PullRequest : Mappable {
    var htmlURL: String? = nil
    var diffURL: String? = nil
    var patchURL: String? = nil
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        htmlURL <- map["html_url"]
        diffURL <- map["diff_url"]
        patchURL <- map["patch_url"]
    }
}