//
//  RealmRepository.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 7/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRepository: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var favourited: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
