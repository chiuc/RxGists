//
//  DetailPresenter.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 8/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class DetailPresenter {
    // MARK: - Private properties -
    private var _view: DetailViewInterface
    private var _interactor: DetailInteractorInterface
    private var _wireframe: DetailWireframeInterface
    private let _repo: Repository
    private let disposeBag = DisposeBag()
    
    private var _items: [Repository] = [] {
        didSet {
            _view.reloadData()
        }
    }
    
    private var _favourite: [RealmRepository] = [] {
        didSet {
            _view.reloadData()
        }
    }
    
    // MARK: - Lifecycle -
    init(wireframe: DetailWireframeInterface, view: DetailViewInterface, interactor: DetailInteractorInterface, repo: Repository) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _repo = repo
    }
}

extension DetailPresenter: DetailPresenterInterface {
    func viewDidLoad() {
        _view.setHeaderImage(with: _repo.owner?.imageUrl)
        _view.setOwnerDetail(with: _repo.owner)
        self._view.setLoadingVisible(true)
        Observable.combineLatest(_interactor.getUserGists(username: (_repo.owner?.name)!)
            , _interactor.getFavouriteList())
            .map {
                self._handleResponse(reposity: $0, favourite: $1)
            }.subscribe { data in
                self._view.setLoadingVisible(false)
            }.disposed(by: disposeBag)
    }
    
    private func _handleResponse(reposity: [Repository], favourite: [RealmRepository]) {
        self._items = reposity
        self._favourite = favourite
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOrItems(in section: Int) -> Int {
        return _items.count
    }
    
    func item(at indexPath: IndexPath) -> DetailViewRepositoryInterface {
        return _items[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        _wireframe.back()
    }
    
    func isFav(at indexPath: IndexPath) -> Bool {
        let fav = _favourite.filter({
            $0.id == _items[indexPath.row].id
        });
        return fav.count > 0
    }
    
    func onFavClicked(at indexPath: IndexPath) {
        self._view.setLoadingVisible(true)
        Observable.combineLatest(_interactor.addFavourite(repository:  _items[indexPath.row]), _interactor.getFavouriteList())
            .map{ (arg) in
                let (_, data ) = arg
                self._heandleFavUpdate(favourite: data)
        }.subscribe{data in
            self._view.setLoadingVisible(false)
        }.disposed(by: disposeBag)
    }
    
    private func _heandleFavUpdate(favourite: [RealmRepository]) {
        self._favourite = favourite
    }
}
