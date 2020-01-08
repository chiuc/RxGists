//
//  HomePresenter.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources



final class HomePresenter {
    // MARK: - Private properties -
    private var _view: HomeViewInterface
    private var _interactor: HomeInteractorInterface
    private var _wireframe: HomeWireframeInterface
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
    init(wireframe: HomeWireframeInterface, view: HomeViewInterface, interactor: HomeInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension HomePresenter: HomePresenterInterface {
    func viewDidLoad() {
        self._view.setLoadingVisible(true)
        Observable.combineLatest(_interactor.getGistList(), _interactor.getFavouriteList())
            .map {
                self._handleResponse(reposity: $0, favourite: $1)
            }.subscribe { data in
                self._view.setLoadingVisible(false)
            }.disposed(by: disposeBag)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOrItems(in section: Int) -> Int {
        return _items.count
    }
    
    func item(at indexPath: IndexPath) -> HomeViewItemInterface {
        return _items[indexPath.row]
    }
    
    func isFav(at indexPath: IndexPath) -> Bool {
        let fav = _favourite.filter({
            $0.id == _items[indexPath.row].id
        });
        return fav.count > 0
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        _wireframe.navigate(to: .details(repo: _items[indexPath.row]))
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
    
    private func _handleResponse(reposity: [Repository], favourite: [RealmRepository]) {
        self._items = reposity
        self._favourite = favourite
    }
    
    private func _updateFac(favourite: [RealmRepository]) {
        
    }
    
    private func _heandleFavUpdate(favourite: [RealmRepository]) {
        self._favourite = favourite
    }
}
