//
//  SearchBar
//  RxGitSearch
//
//  Created by burt on 2016. 2. 6..
//  Copyright © 2016년 burt. All rights reserved.
//
//  skyfe79@gmail.com
//  http://blog.burt.pe.kr
//  http://github.com/skyfe79

import UIKit
import SwiftString
import RxSwift
import RxCocoa

class SearchBar: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var leftBarButton: UIButton!
    @IBOutlet weak var rightBarButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var rx_tapLeftBarButton : PublishSubject<AnyObject> = PublishSubject()
    var rx_tapRightBarButton : PublishSubject<AnyObject>  = PublishSubject()
    var rx_searchText: PublishSubject<String> = PublishSubject()
    var rx_becameFirstResponder : PublishSubject<Bool> = PublishSubject()
    var rx_pressSearchButton: PublishSubject<String> = PublishSubject()
    
    static func view() -> SearchBar {
        
        let sb = NSBundle.mainBundle().loadNibNamed(String(self), owner: self, options: nil).first as! SearchBar
        sb.setBackgroundImage()
        sb.setupRx()
        
        return sb
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func becomeFirstResponder() -> Bool {
        return textfield.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        return textfield.resignFirstResponder()
    }
    
    
    func setLeftBarButtonImage(image: UIImage, state: UIControlState = .Normal) {
        leftBarButton.setImage(image, forState: state)
    }
    
    func setRightBarButtonImage(image: UIImage, state: UIControlState = .Normal) {
        rightBarButton.setImage(image, forState: .Normal)
    }
    
    func setText(str: String) {
        textfield.text = str
    }
}

// MARK:- Private Methods
extension SearchBar {
    
    private func setBackgroundImage() {
        let image = UIImage(named: "search_bar_bg")?.resizableImageWithCapInsets(UIEdgeInsetsMake(4, 4, 4, 4))
        backgroundImageView.image = image
    }
    private func setupRx() {
        
        textfield
            .rx_controlEvent(.EditingDidBegin)
            .subscribeNext { [unowned self] in
                self.rx_becameFirstResponder.onNext(true)
            }
            .addDisposableTo(disposeBag)
        
        textfield
            .rx_controlEvent(.EditingDidEndOnExit)
            .subscribeNext { [unowned self] in
                self.rx_becameFirstResponder.onNext(false)
            }
            .addDisposableTo(disposeBag)
        
        textfield
            .rx_text
            .bindTo(rx_searchText)
            .addDisposableTo(disposeBag)
    
        // 검색을 눌렀을 경우 실행한다.
        textfield
            .rx_controlEvent(.EditingDidEndOnExit)
            .filter {
                if let text = self.textfield.text {
                    if text.trimmed().length != 0 {
                        return true
                    }
                }
                return false
            }
            .flatMapLatest { [unowned self] in
                return Observable.just(self.textfield.text!)
            }
            .bindTo(rx_pressSearchButton)
            .addDisposableTo(disposeBag)
    }
}



// MARK:- IBActions
extension SearchBar {
    @IBAction func leftBarButtonItemClicked(sender: AnyObject) {
        rx_tapLeftBarButton.onNext(sender)
    }
    
    @IBAction func rightBarButtonItemClicked(sender: AnyObject) {
        rx_tapRightBarButton.onNext(sender)
    }
}
