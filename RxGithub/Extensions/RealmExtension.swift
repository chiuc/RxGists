//
//  RealmExtension.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 7/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    static func create() -> Realm {
        do { return try Realm() }
        catch let e as NSError {
            fatalError("Failed to create Realm instance: \(e.localizedDescription)")
        }
    }
    
    init?(error: inout PersistenceError?) {
        do { try self.init() }
        catch let e as NSError {
            print("Failed to create Realm instance: \(e.localizedDescription)")
            error = .persistenceIntialization
            return nil
        }
    }

    func write(error: inout PersistenceError?, transaction: ()->Void){
    
        do { try write { transaction() } }
        catch let e as NSError {
            print("Failed to commit Realm transaction: \(e.localizedDescription)")
            error = PersistenceError(from: e)
        }
    }
}
