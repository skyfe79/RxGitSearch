//
//  SearchAdapter.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79


import UIKit

class SearchAdapter: NSObject, UITableViewDataSource {
    
    var items : [Repository]? = nil
    
    override init() {
        super.init()
        // register cell nibs ...
    }
    
    func updateDatasource(items : [Repository]) {
        self.items = items
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        if let item = self.items?[indexPath.row] {
        
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.fullName
        }
        return cell
    }
    
}
