//
//  RepositoryOwner.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//

import ObjectMapper

struct RepositoryOwner : Mappable {
    
    var login: String
    var id: Int
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var receivedEventsUrl: String
    var type: String
    
    init?(_ map: Map) {
        login = ""
        id = 0
        avatarUrl = ""
        gravatarId = ""
        url = ""
        receivedEventsUrl = ""
        type = ""
    }
    
    
    mutating func mapping(map: Map) {
        login <- map["login"]
        id <- map["id"]
        avatarUrl <- map["avatar_url"]
        gravatarId <- map["gravatar_id"]
        url <- map["url"]
        receivedEventsUrl <- map["received_events_url"]
        type <- map["type"]
    }
    
    
}