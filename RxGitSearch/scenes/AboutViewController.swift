//
//  AboutViewController.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 6..
//  Copyright © 2016년 burt. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AboutViewController: BaseViewController {

    var viewModel : AboutViewModel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var webView: UIWebView!

    
    override func setViewModel(viewModel: ViewModelType) {
        if let vm = viewModel as? AboutViewModel {
            self.viewModel = vm
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.activated()
        setupRightBarButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://github.com/skyfe79")!))
    }
}

extension AboutViewController {
    
    func setupRightBarButton() {
                
        closeButton
            .rx_tap
            .subscribeNext {
                Route.back("app://rxgitsearch/about", from: self)
            }
            .addDisposableTo(disposeBag)
    }
}
