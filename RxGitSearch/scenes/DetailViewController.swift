//
//  DetailViewController.swift
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

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    var viewModel : DetailViewModel!
    
    override func setViewModel(viewModel: ViewModelType) {
        if let vm = viewModel as? DetailViewModel {
            self.viewModel = vm
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        viewModel.activated()
        setupRx()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
}

extension DetailViewController {
    func setupRx() {
        
        backButton
            .rx_tap
            .subscribeNext { [unowned self] in
                
                if let fullname = self.viewModel.repoFullName() {
                    Route.back("app://repository/detail/:id", from: self, result: "Wow, You're back from " + fullname)
                } else {
                    Route.back("app://repository/detail/:id", from: self, result: "Wow, You're Back!")
                }
                
            }
            .addDisposableTo(disposeBag)
        
        aboutButton
            .rx_tap
            .subscribeNext { [unowned self] in
                if let nav = self.navigationController {
                    Route.present(nav, url: "app://rxgitsearch/about?url=https://github.com/skyfe79") { [unowned self] (vc, result) in
                        self.navigationController?.navigationBarHidden = true
                        vc.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
            .addDisposableTo(disposeBag)
        
        
        viewModel.rx_Owner()?
            .map { (owner) -> String in
                String(owner)
            }
            .subscribeNext { [unowned self] str in
                self.textView.text = str
            }
            .addDisposableTo(disposeBag)
        
        segmentedControl.rx_value
            .subscribeNext { [unowned self] index in
                if index == 0 {
                    self.showRepositoryString()
                } else {
                    self.showOwnerString()
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func showRepositoryString() {
        viewModel.rx_Repository()?
            .map { (repo) -> String in
                String(repo)
            }
            .subscribeNext { [unowned self] str in
                self.textView.text = str
            }
            .addDisposableTo(disposeBag)
    }
    
    func showOwnerString() {
        viewModel.rx_Owner()?
            .map { (owner) -> String in
                String(owner)
            }
            .subscribeNext { [unowned self] str in
                self.textView.text = str
            }
            .addDisposableTo(disposeBag)
    }
}

