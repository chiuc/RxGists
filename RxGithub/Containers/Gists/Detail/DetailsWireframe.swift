//
//  DetailsWireframe.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 8/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit

final class DetailsWireframe: BaseWireframe {
    
    private let _storyboard = UIStoryboard(name: "Detail", bundle: nil)
    
    init(repo: Repository) {
        let moduleViewController = _storyboard.instantiateViewController(ofType: DetailViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(wireframe: self, view: moduleViewController, interactor: interactor, repo: repo)
        moduleViewController.presenter = presenter
    }
}

extension DetailsWireframe : DetailWireframeInterface{
    func navigate(to option: HomeNavigationOption) {
        
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
