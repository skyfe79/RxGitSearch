//
//  Item.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import ObjectMapper

struct Repository : Mappable {
    
    var id: Int = 0                        // you should use NSNumber but just for convenience, we use Int type.
    var name: String? = nil
    var fullName: String? = nil
    var owner: Owner? = nil
    var isPrivate: Bool = false
    var htmlUrl: String? = nil
    var description: String? = nil
    var isForked: Bool = false
    var url: String? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    var pushedAt: String? = nil
    var homepage: String? = nil
    var size: Int = 0
    var starCount: Int = 0
    var watcherCount: Int = 0
    var language: String? = nil
    var forkCount: Int = 0
    var openIssueCount: Int = 0
    var masterBranchName: String? = nil
    var defaultBranchName: String? = nil
    var score: Double = 0.0

    /* Oops so many to type this -_-
    "forks_url": "https:api.github.com/repos/jquery/jquery/forks",
    "keys_url": "https:api.github.com/repos/jquery/jquery/keys{/key_id}",
    "collaborators_url": "https:api.github.com/repos/jquery/jquery/collaborators{/collaborator}",
    "teams_url": "https:api.github.com/repos/jquery/jquery/teams",
    "hooks_url": "https:api.github.com/repos/jquery/jquery/hooks",
    "issue_events_url": "https:api.github.com/repos/jquery/jquery/issues/events{/number}",
    "events_url": "https:api.github.com/repos/jquery/jquery/events",
    "assignees_url": "https:api.github.com/repos/jquery/jquery/assignees{/user}",
    "branches_url": "https:api.github.com/repos/jquery/jquery/branches{/branch}",
    "tags_url": "https:api.github.com/repos/jquery/jquery/tags",
    "blobs_url": "https:api.github.com/repos/jquery/jquery/git/blobs{/sha}",
    "git_tags_url": "https:api.github.com/repos/jquery/jquery/git/tags{/sha}",
    "git_refs_url": "https:api.github.com/repos/jquery/jquery/git/refs{/sha}",
    "trees_url": "https:api.github.com/repos/jquery/jquery/git/trees{/sha}",
    "statuses_url": "https:api.github.com/repos/jquery/jquery/statuses/{sha}",
    "languages_url": "https:api.github.com/repos/jquery/jquery/languages",
    "stargazers_url": "https:api.github.com/repos/jquery/jquery/stargazers",
    "contributors_url": "https:api.github.com/repos/jquery/jquery/contributors",
    "subscribers_url": "https:api.github.com/repos/jquery/jquery/subscribers",
    "subscription_url": "https:api.github.com/repos/jquery/jquery/subscription",
    "commits_url": "https:api.github.com/repos/jquery/jquery/commits{/sha}",
    "git_commits_url": "https:api.github.com/repos/jquery/jquery/git/commits{/sha}",
    "comments_url": "https:api.github.com/repos/jquery/jquery/comments{/number}",
    "issue_comment_url": "https:api.github.com/repos/jquery/jquery/issues/comments/{number}",
    "contents_url": "https:api.github.com/repos/jquery/jquery/contents/{+path}",
    "compare_url": "https:api.github.com/repos/jquery/jquery/compare/{base}...{head}",
    "merges_url": "https:api.github.com/repos/jquery/jquery/merges",
    "archive_url": "https:api.github.com/repos/jquery/jquery/{archive_format}{/ref}",
    "downloads_url": "https:api.github.com/repos/jquery/jquery/downloads",
    "issues_url": "https:api.github.com/repos/jquery/jquery/issues{/number}",
    "pulls_url": "https:api.github.com/repos/jquery/jquery/pulls{/number}",
    "milestones_url": "https:api.github.com/repos/jquery/jquery/milestones{/number}",
    "notifications_url": "https:api.github.com/repos/jquery/jquery/notifications{?since,all,participating}",
    "labels_url": "https:api.github.com/repos/jquery/jquery/labels{/name}"
    */
    init?(_ map: Map) {
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