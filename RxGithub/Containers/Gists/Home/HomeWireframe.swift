//
//  HomeWireframe.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit

final class HomeWireframe: BaseWireframe {
    
    // MARK: - Private properties -
    private let _storyboard = UIStoryboard(name: "Home", bundle: nil)
    
    // MARK: - Module setup -
    init() {
        let moduleViewController = _storyboard.instantiateViewController(ofType: HomeViewController.self)
        super.init(viewController: moduleViewController)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }
}

extension HomeWireframe: HomeWireframeInterface {
    func navigate(to option: HomeNavigationOption) {
        switch option {
            case .details(let repo):
                self._openDetails(with: repo);
        }
    }
    
    private func _openDetails(with repo: Repository) {
        navigationController?.pushViewController(DetailsWireframe(repo: repo).viewController, animated: true);
    }
}
