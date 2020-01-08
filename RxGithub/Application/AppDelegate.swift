//
//  AppDelegate.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var initializers: [Initializable] = [
        AlamofireInitializer(),
        ThemeInitializer(),
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializers.forEach { $0.performInitialization() }
        let initialController = UINavigationController();
        initialController.setRootWireframe(HomeWireframe());
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = initialController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

