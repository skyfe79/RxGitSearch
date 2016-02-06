//
//  ViewController.swift
//  RxGitSearch
//
//  Created by burt.k(Sungcheol Kim) on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import UIKit
import RxSwift
import RxCocoa
class SearchViewController: BaseViewController {
    
    // widgets
    @IBOutlet weak var tableView : UITableView!
    var searchBar: SearchBar!
    
    // vm
    var viewModel: SearchViewModel!
    
    deinit {
        searchBar = nil
        viewModel = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupSearchBar()
        setupTableView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
}


extension SearchViewController {
    
    func setupViewModel() {
        viewModel = SearchViewModel()
        
        viewModel
            .rx_onError
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribeOn(MainScheduler.instance)
            .subscribeNext { [unowned self] (error) -> Void in
                let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                    
                    self.setupViewModel()
                    self.setupSearchBar()
                    
                    alert.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
            .addDisposableTo(disposeBag)
        
        self.tableView.dataSource = viewModel.adapter
        viewModel
            .rx_updatedAdapter
            .subscribeOn(MainScheduler.instance)
            .subscribe { [unowned self] event in
                if let _ = event.element {
                    self.tableView.reloadData()
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func setupSearchBar() {
        searchBar = SearchBar.view()
        self.navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        
        searchBar
            .rx_searchText
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bindTo(viewModel.rx_fetchSearchSuggestRepository)
            .addDisposableTo(disposeBag)
        
        searchBar
            .rx_pressSearchButton
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bindTo(viewModel.rx_fetchSearchRepository)
            .addDisposableTo(disposeBag)
    }
    
    func setupTableView() {
        tableView
            .rx_itemSelected
            .subscribeOn(MainScheduler.instance)
            .subscribeNext { [unowned self] (indexPath) -> Void in
                if let repo = self.viewModel.repositoryAtIndex(indexPath.row) {
                    
                }
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
            .addDisposableTo(disposeBag)
    }
    
}
