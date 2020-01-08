//
//  DetailViewController.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 8/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher
import JGProgressHUD
import JJFloatingActionButton

final class DetailViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pageLabel: UILabel!
    
    //MARK: Flow
    var presenter: DetailPresenterInterface!
    let disposeBag = DisposeBag()
    let actionButton = JJFloatingActionButton()
    let hud = JGProgressHUD(style: .dark)
    
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

extension DetailViewController: DetailViewInterface {
    func setViewTitle(_ title: String?) {
        
    }
    
    func setHeaderImage(with url: URL?) {
        guard url != nil else {
           headerImageView.image = #imageLiteral(resourceName: "image-placeholder")
           return
        }
        headerImageView.kf.setImage(with: url)
    }
    
    func setOwnerDetail(with owner: Owner?){
        nameLabel.text = owner?.name
        pageLabel.text = owner?.htmlURL
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setEmptyPlaceholderHidden(_ hidden: Bool) {
        
    }
    
    func setLoadingVisible(_ visible: Bool) {
        if visible {
            hud.show(in: self.view, animated: true)
        } else {
            hud.dismiss(animated: true)
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOrItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailRepositoriesCell", for: indexPath) as! DetailTableViewCell
        let item = presenter.item(at: indexPath)
        cell.delegate = self
        cell.indexPath = indexPath
        cell.configure(with: item, isFav: presenter.isFav(at: indexPath))
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}

extension DetailViewController: DetailCellFavButtonsDelegate{
    func onFavTapped(at indexPath: IndexPath) {
        presenter.onFavClicked(at: indexPath)
    }
}
