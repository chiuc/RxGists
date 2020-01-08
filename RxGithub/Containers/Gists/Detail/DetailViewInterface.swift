//
//  DetailViewInterface.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 8/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailWireframeInterface: BaseWireframeInterface {
    func navigate(to option: HomeNavigationOption)
    func back()
}

protocol DetailViewInterface: BaseViewInterface {
    func reloadData()
    func setViewTitle(_ title: String?)
    func setHeaderImage(with url: URL?)
    func setOwnerDetail(with owner: Owner?)
    func setLoadingVisible(_ visible: Bool)
}

protocol DetailPresenterInterface: BasePresenterInterface {
    func numberOfSections() -> Int
    func numberOrItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> DetailViewRepositoryInterface
    func isFav(at indexPath: IndexPath) -> Bool
    func didSelectItem(at indexPath: IndexPath)
    func onFavClicked(at indexPath: IndexPath)
}

protocol DetailInteractorInterface: BaseInteractorInterface {
    func getUserGists(username: String) -> Observable<[Repository]>;
    func getFavouriteList() -> Observable<[RealmRepository]>;
    func addFavourite(repository: Repository) -> Observable<Bool>
    func unFavourite(repository: Repository) -> Observable<Bool>
}

protocol DetailViewOwnerItemInterface {
    var name: String? { get }
    var url: String? { get }
    var htmlURL: String? { get }
    var imageUrl: URL? { get }
}

protocol DetailViewRepositoryInterface {
    var id: String? { get }
    var url: String? { get }
    var name: String? { get }
    var imageUrl: URL? { get }
    var files: [String : File]? { get }
    var description: String? { get }
}
