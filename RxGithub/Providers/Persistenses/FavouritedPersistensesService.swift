//
//  FavouritedRealmService.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 7/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class FavouritedPersistensesService {
    
    private let _realm = try! Realm()
    
    func getFavouritedList() -> Observable<[RealmRepository]>{
        return Observable.array(from: _realm.objects(RealmRepository.self))
            .map { data in
                data.map { item in
                    return RealmRepository(value: item)
                }
        }
    }
    
    func addFavourite(repository: Repository) -> Observable<Bool>{
        return Observable.create { observer in
            self.addFavouriteRepository(repository: repository, completion: nil)
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
     func unFavourite(repository: Repository) -> Observable<Bool>{
        return Observable.create { observer in
            self.removeFavouriteRepository(repository: repository, completion: nil)
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func addFavouriteRepository(repository: Repository, completion: persistenceErrorHandler?) {
        DispatchQueue.global(qos: .userInitiated).async {
            print("CHIU addFavouriteRepository #START")
            var error: PersistenceError?
            defer {
                completion?(error)
            }
            guard let realm = Realm(error: &error) else { return }
            let favourite: RealmRepository = RealmRepository()
            favourite.id = repository.id!;
            favourite.favourited = true
            realm.write(error: &error) {
                realm.add(favourite)
            }
            print("CHIU addFavouriteRepository #DONE")
        }
    }
    
    func removeFavouriteRepository(repository: Repository, completion: persistenceErrorHandler?) {
        DispatchQueue.global(qos: .userInitiated).async {
            var error: PersistenceError?
            defer {
                completion?(error)
            }
            guard let realm = Realm(error: &error) else { return }
            let predicate = NSPredicate(format: "id == %@", repository.id!);
            if let itemToDelete = realm.objects(RealmRepository.self).filter(predicate).first {
                realm.write(error: &error) {
                    realm.delete(itemToDelete)
                }
            }
        }
    }
}
