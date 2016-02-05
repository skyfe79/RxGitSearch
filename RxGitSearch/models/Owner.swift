//
//  RepositoryOwner.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

struct Owner : Mappable {
    
    var login: String? = nil
    var id: Int = 0
    var avatarURL: String? = nil
    var gravatarId: String? = nil
    var url: String? = nil
    var receivedEventsURL: String? = nil
    var type: String? = nil
    var htmlURL: String? = nil
    var followersURL: String? = nil
    var followingURL: String? = nil
    var gistsURL: String? = nil
    var starredURL: String? = nil
    var subscriptionsURL: String? = nil
    var organizationsURL: String? = nil
    var reposURL: String? = nil
    var eventsURL: String? = nil
    var isSiteAdmin = false
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        login <- map["login"]
        id <- map["id"]
        avatarURL <- map["avatar_url"]
        gravatarId <- map["gravatar_id"]
        url <- map["url"]
        receivedEventsURL <- map["received_events_url"]
        type <- map["type"]
        htmlURL <- map["html_url"]
        followersURL <- map["followers_url"]
        followingURL <- map["following_url"]
        gistsURL <- map["gists_url"]
        starredURL <- map["starred_url"]
        subscriptionsURL <- map["subscriptions_url"]
        organizationsURL <- map["organizations_url"]
        reposURL <- map["repos_url"]
        eventsURL <- map["events_url"]
        isSiteAdmin <- map["site_admin"]
    }
    
}