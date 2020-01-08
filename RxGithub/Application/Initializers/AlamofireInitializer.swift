//
//  AlamofireInitializer.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator

class AlamofireInitializer: Initializable {
    func performInitialization() {
        let networkActivityManager = NetworkActivityIndicatorManager.shared
        networkActivityManager.isEnabled = true
        networkActivityManager.startDelay = 0
        
//        Alamofire.SessionManager.default.adapter = AuthorizationAdapter.shared
    }
}
