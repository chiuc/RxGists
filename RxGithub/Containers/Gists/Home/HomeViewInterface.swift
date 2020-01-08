//
//  HomeViewInterface.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum HomeNavigationOption {
    case details(repo: Repository)
}

protocol HomeWireframeInterface: BaseWireframeInterface {
    func navigate(to option: HomeNavigationOption)
}

protocol HomeViewInterface: BaseViewInterface {
    func reloadData()
    func setLoadingVisible(_ visible: Bool)
}

protocol HomePresenterInterface: BasePresenterInterface {
    func numberOfSections() -> Int
    func numberOrItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> HomeViewItemInterface
    func isFav(at indexPath: IndexPath) -> Bool
    func didSelectItem(at indexPath: IndexPath)
    func onFavClicked(at indexPath: IndexPath)
}

protocol HomeInteractorInterface: BaseInteractorInterface {
    func getGistList() -> Observable<[Repository]>;
    func getFavouriteList() -> Observable<[RealmRepository]>;
    func addFavourite(repository: Repository) -> Observable<Bool>
    func unFavourite(repository: Repository) -> Observable<Bool>
}

protocol HomeViewItemInterface {
    var id: String? { get }
    var url: String? { get }
    var name: String? { get }
    var imageUrl: URL? { get }
    var files: [String : File]? { get }
}
