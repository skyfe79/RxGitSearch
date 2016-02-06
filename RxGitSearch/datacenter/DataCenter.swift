//
//  DataCenter.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 6..
//  Copyright © 2016년 burt. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DataCenter {
    
    static let instance = DataCenter()

    let disposeBag = DisposeBag()
    var operationQueue : NSOperationQueue!
    var backgroundWorkScheduler : OperationQueueScheduler!
    
    // REST API Service
    // DBService
    // NSUserDefault
    // Sensor
    // System Notification
    // ...
        
    private init() {
        setupBackgroundWorkScheduler()
    }
    
    var rx_onError : PublishSubject<NSError> = PublishSubject()
}

extension DataCenter {
    func setupBackgroundWorkScheduler() {
        operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
    }
}

extension DataCenter {
    
    func rx_searchGithubRepository(parameter : SearchParameter, mapFunctor: (SearchRepositoryResponse) -> Observable<[Repository]>) -> Observable<[Repository]> {
        return GithubService<SearchRepositoryResponse>
            .rx_search(.REPOSITORY, parameter: parameter)
            .flatMap { response in
                mapFunctor(response)
            }
            .subscribeOn(backgroundWorkScheduler)
            .doOn(
                onNext: { repoItemList in
                    // you can do something with repoItemList like storing them to db
                },
                onError: { error in
                    
                }, onCompleted: nil
            )
            .asObservable()
    }

    
}