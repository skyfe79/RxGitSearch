//
//  Issue.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

struct Issue : Mappable {
    var url: String? = nil
    var repositoryURL: String? = nil
    var labelsURL: String? = nil
    var commentsURL: String? = nil
    var eventsURL: String? = nil
    var htmlURL: String? = nil
    var id: Int = 0
    var number: Int = 0
    var title: String? = nil
    var user: User? = nil
    var labels : [Label] = [Label]()
    var state: String? = nil
    var assignee: String? = nil
    var milestone: String? = nil
    var commentCount: Int = 0
    var createdAt: String? = nil
    var closedAt: String? = nil
    var pullRequest: PullRequest? = nil
    var body: String? = nil
    var score: Double = 0.0
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        url <- map["url"]
        repositoryURL <- map["repository_url"]
        labelsURL <- map["labels_url"]
        commentsURL <- map["comments_url"]
        eventsURL <- map["events_url"]
        htmlURL <- map["html_url"]
        id <- map["id"]
        number <- map["number"]
        title <- map["title"]
        user <- map["user"]
        labels <- map["labels"]
        state <- map["state"]
        assignee <- map["assignee"]
        milestone <- map["milestone"]
        commentCount <- map["comment_count"]
        createdAt <- map["created_at"]
        closedAt <- map["closed_at"]
        pullRequest <- map["pull_request"]
        body <- map["body"]
        score <- map["score"]
    }
}