//
//  user.service.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
import RxSwift

class UserService: NSObject {
    
    var loginState: Bool = false;
    let isLoggedIn = ReplaySubject<Bool>.create(bufferSize: 1);
    
    override init() {
        super.init()
        self.updateLoginState(loginState: false);
    }
    
    public func updateLoginState(loginState: Bool) {
        if (self.loginState != loginState) {
            self.loginState = loginState;
            self.isLoggedIn.onNext(self.loginState);
        }
    }
}
