//
//  HomeViewController.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import JGProgressHUD

final class HomeViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: Flow
    var presenter: HomePresenterInterface!
    let disposeBag = DisposeBag()
    let hud = JGProgressHUD(style: .dark)
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupBindings()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func setupBindings() {
        
    }
}

// MARK: - Extensions -

extension HomeViewController: HomeViewInterface {
    func reloadData() {
        tableView.reloadData()
    }
    
    func setLoadingVisible(_ visible: Bool) {
        if visible {
            hud.show(in: self.view, animated: true)
        } else {
            hud.dismiss(animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOrItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! HomeTableViewCell
        let item = presenter.item(at: indexPath)
        cell.delegate = self
        cell.indexPath = indexPath
        cell.configure(with: item, isFav: presenter.isFav(at: indexPath))
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}

extension HomeViewController: FavButtonsDelegate{
    func onFavTapped(at indexPath: IndexPath) {
        presenter.onFavClicked(at: indexPath)
    }
}
