//
//  app.service.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 6/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
import Localize_Swift

class AppService: NSObject {
    
    
    public static func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
