//
//  SearchViewModel.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 5..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79


import Foundation
import RxSwift
import RxCocoa

class SearchViewModel : BaseViewModel, ViewModelType {
    
    let disposeBag = DisposeBag()
    
    //Binding
    var rx_fetchSearchSuggestRepository : PublishSubject<String> = PublishSubject()
    var rx_fetchSearchRepository : PublishSubject<String> = PublishSubject()
    var rx_onError : PublishSubject<NSError> = PublishSubject()
    
    //Adapter
    var adapter : SearchAdapter = SearchAdapter()
    var rx_updatedAdapter : PublishSubject<String> = PublishSubject()
    
    func activated() {
        setupFetchSearchSuggestRepository()
        setupFetchSearchRepository()
    }
}

extension SearchViewModel {
    
    func setupFetchSearchSuggestRepository() {
        
        // send request
        rx_fetchSearchSuggestRepository
            .filter { str in
                str.trimmed().length >= 2
            }
            .flatMapLatest { str -> Observable<SearchParameter> in
                let param = SearchParameter.Builder()
                    .query(str)
                    .sort(SortType.STARS)
                    .order(OrderType.DESC)
                    .build()
                return Observable.just(param)
            }
            .flatMap { parameter in
                
                DataCenter.instance.rx_searchGithubRepository(parameter, mapFunctor: { (response) -> Observable<[Repository]> in
                    response.items
                        .toObservable()
                        .take(5)
                        .toArray()
                })
                
            }
            .subscribe { event in
                
                if let error = event.error {
                    self.rx_onError.onNext(error as NSError)
                } else if let items = event.element {
                    self.adapter.updateDatasource(items)
                    self.rx_updatedAdapter.onNext("")
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func setupFetchSearchRepository() {
        
        // send request
        rx_fetchSearchRepository
            .flatMapLatest { str -> Observable<SearchParameter> in
                let param = SearchParameter.Builder()
                    .query(str)
                    .sort(SortType.STARS)
                    .order(OrderType.DESC)
                    .build()
                return Observable.just(param)
            }
            .flatMap { parameter in
                DataCenter.instance.rx_searchGithubRepository(parameter, mapFunctor: { (response) -> Observable<[Repository]> in
                    response.items
                        .toObservable()
                        .toArray()
                })
            }
            .subscribe { event in
                
                if let error = event.error {
                    self.rx_onError.onNext(error as NSError)
                } else if let items = event.element {
                    self.adapter.updateDatasource(items)
                    self.rx_updatedAdapter.onNext("")
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func repositoryAtIndex(index: Int) -> Repository? {
        if let items = adapter.items {
            if index < items.count {
                return items[index]
            }
        }
        return nil
    }
}
