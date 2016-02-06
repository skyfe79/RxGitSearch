//
//  DetailViewModel.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 6..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79


import Foundation
import RxSwift
import RxCocoa

class DetailViewModel : NSObject, ViewModelType {

    let disposeBag = DisposeBag()
    var id: String? = nil
    var repo: Repository? = nil
    var owner: Owner? = nil
    
    func activated() {
        setupRx()
    }
}

extension DetailViewModel {
    func setupRx() {
        
        DataCenter.instance
            .receive(id!)?
            .asObservable()
            .subscribeNext { [unowned self] (value: Any) -> Void in
                if let repo = value as? Repository {
                    self.repo = repo
                    self.owner = repo.owner
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func rx_Repository() -> Observable<Repository>? {
        if let repo = self.repo {
            return Observable.just(repo)
        }
        return nil
    }
    
    func rx_Owner() -> Observable<Owner>? {
        if let owner = self.owner {
            return Observable.just(owner)
        }
        return nil
    }
    
    func repoFullName() -> String? {
        if let repo = self.repo {
            return repo.fullName
        }
        return nil
    }
}