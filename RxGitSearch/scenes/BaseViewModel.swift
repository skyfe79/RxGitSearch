//
//  BaseViewModel.swift
//  RxGitSearch
//
//  Created by burt on 2016. 2. 22..
//  Copyright © 2016년 burt. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel : NSObject {
    
    func post(name: String, value: Any) {
        DataCenter.instance.post(name, value: value)
    }
    
    func receive(name: String) -> Variable<Any>? {
        return DataCenter.instance.receive(name)
    }
    
}