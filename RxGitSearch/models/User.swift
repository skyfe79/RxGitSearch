//
//  User.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

struct User : Mappable {
    
    var login: String? = nil
    var id: Int = 0
    var avatarURL: String? = nil
    var gravatarURL: String? = nil
    var url: String? = nil
    var htmlURL: String? = nil
    var followersURL: String? = nil
    var subscriptionsURL: String? = nil
    var organizationsURL: String? = nil
    var reposURL: String? = nil
    var receivedEventsURL: String? = nil
    var type: String? = nil
    var score: Double = 0.0
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        login <- map["login"]
        id <- map["id"]
        avatarURL <- map["avatar_url"]
        gravatarURL <- map["gravatar_url"]
        url <- map["url"]
        htmlURL <- map["html_url"]
        followersURL <- map["followers_url"]
        subscriptionsURL <- map["subscriptions_url"]
        organizationsURL <- map["organizations_url"]
        reposURL <- map["repos_url"]
        receivedEventsURL <- map["received_events_url"]
        type <- map["type"]
        score <- map["score"]
    }
}
