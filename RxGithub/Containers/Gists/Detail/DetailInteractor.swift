//
//  DetailInteractor.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 8/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailInteractor {
    fileprivate let _gistsService: GistsAPIService = GistsAPIService()
    fileprivate let _favouritedService: FavouritedPersistensesService = FavouritedPersistensesService()
}

extension DetailInteractor: DetailInteractorInterface {

    func getUserGists(username: String) -> Observable<[Repository]> {
        return _gistsService.getGistsByUser(username: username)
    }
    
    func getFavouriteList() -> Observable<[RealmRepository]> {
        return _favouritedService.getFavouritedList()
    }
    
    func addFavourite(repository: Repository) -> Observable<Bool>{
        return _favouritedService.addFavourite(repository: repository)
    }
    
    func unFavourite(repository: Repository) -> Observable<Bool>{
         return _favouritedService.unFavourite(repository: repository)
    }
}
