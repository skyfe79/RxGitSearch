//
//  BaseViewController.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 6..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79


import UIKit
import RxSwift
import RxCocoa

class BaseViewController : UIViewController, RoutableViewController {
    
    var disposeBag = DisposeBag()
    
    func setViewModel(viewModel: ViewModelType) {
    }
}
