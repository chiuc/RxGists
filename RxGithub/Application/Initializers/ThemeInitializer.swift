//
//  ThemeInitializer.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit

class ThemeInitializer: Initializable {
    func performInitialization() {
        UINavigationBar.appearance(whenContainedInInstancesOf: [RxGithubNavigationController.self]).tintColor = .black
        UINavigationBar.appearance(whenContainedInInstancesOf: [RxGithubNavigationController.self]).titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
