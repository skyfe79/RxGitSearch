//
//  Item.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//

import ObjectMapper

struct RepositoryItem : Mappable {
    
    var id: Int                         // you should use NSNumber but just for convenience, we use Int type.
    var name: String
    var fullName: String
    var owner: RepositoryOwner?
    var isPrivate: Bool
    var htmlUrl: String
    var description: String
    var isForked: Bool
    var url: String
    var createdAt: String
    var updatedAt: String
    var pushedAt: String
    var homepage: String
    var size: Int
    var starCount: Int
    var watcherCount: Int
    var language: String
    var forkCount: Int
    var openIssueCount: Int
    var masterBranchName: String
    var defaultBranchName: String
    var score: Double
    
    init?(_ map: Map) {
        id = 0
        name = ""
        fullName = ""
        isPrivate = false
        htmlUrl = ""
        description = ""
        isForked = false
        url = ""
        createdAt = ""
        updatedAt = ""
        pushedAt = ""
        homepage = ""
        size = 0
        starCount = 0
        watcherCount = 0
        language = ""
        forkCount = 0
        openIssueCount = 0
        masterBranchName = ""
        defaultBranchName = ""
        score = 0.0
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        owner <- map["owner"]
        isPrivate <- map["private"]
        htmlUrl <- map["html_url"]
        description <- map["description"]
        isForked <- map["fork"]
        url <- map["url"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        pushedAt <- map["pushed_at"]
        homepage <- map["homepage"]
        size <- map["size"]
        starCount <- map["stargazers_count"]
        watcherCount <- map["watchers_count"]
        language <- map["language"]
        forkCount <- map["forks_count"]
        openIssueCount <- map["open_issues_count"]
        masterBranchName <- map["master_branch"]
        defaultBranchName <- map["default_branch"]
        score <- map["score"]
    }
    
    
}