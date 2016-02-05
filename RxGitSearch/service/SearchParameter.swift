//
//  SearchRepositoryParameter.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

//  This is query parameter for searching github repository
//  @see https://developer.github.com/v3/search
//
//  /search/respository
//  /search/code
//  /search/issue
//  /search/users
// 
//  The q and language is common paramter to search upper subjects.
//  If you want to search code, you must include at least on user, organization or repository
//  +repo:blahblah 

enum SortType : String {
    case STARS = "stars"
    case FORKS = "forks"
    case UPDATED = "updated"
}

enum OrderType : String {
    case ASC = "asc"
    case DESC = "desc"
}

final class SearchParameter {
    var params : [String:AnyObject] = [:]
    
    private init() {
        // You should use Builder
    }
    
    private func add(name: String, value: AnyObject) {
        params[name] = value
    }
    
    private func remove(name: String) {
        if params.keys.contains(name) {
            params.removeValueForKey(name)
        }
    }
    
    class Builder {
        private var parameter : SearchParameter!
        var query : String!
        var language : String? = nil
        var repository : String? = nil
        
        init() {
            parameter = SearchParameter()
            query = ""
        }
        
        func query(q: String) -> Builder {
            query = q
            return self
        }
        
        func language(lang: String?) -> Builder {
            language = lang
            return self
        }
        
        func repository(repo: String?) -> Builder {
            repository = repo
            return self
        }
        
        func sort(sort: SortType) -> Builder {
            parameter.add("sort", value: sort.rawValue)
            return self
        }
        
        func order(order: OrderType) ->Builder {
            parameter.add("order", value: order.rawValue)
            return self
        }
        
        func build() -> SearchParameter {
            
            if let lang = language {
                query = query + "+language:\(lang)"
            }
            
            if let repo = repository {
                query = query + "+repo:\(repo)"
            }
            
            parameter.add("q", value: query)
            
            
            return parameter
        }
        
    }
}
