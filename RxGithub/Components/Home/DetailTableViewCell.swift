//
//  DetailTableViewCell.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 8/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit

protocol DetailCellFavButtonsDelegate{
    func onFavTapped(at index:IndexPath)
}

class DetailTableViewCell: UITableViewCell {
    var delegate:DetailCellFavButtonsDelegate!
    var indexPath:IndexPath!
    
    @IBOutlet weak var cellFileNameLabel: UILabel!
    @IBOutlet weak var cellURLLabel: UILabel!
    @IBOutlet weak var cellFavButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func onFavClick() {
        self.delegate?.onFavTapped(at: indexPath)
    }
    
    func configure(with item: DetailViewRepositoryInterface, isFav: Bool) {
        if ((item.description) != "") {
            cellFileNameLabel.text = item.description
        } else {
            var fileStr = ""
            for (key, _) in item.files! {
                if (fileStr == "") {
                    fileStr = key
                }
            }
            cellFileNameLabel.text = fileStr
        }
        cellURLLabel.text = item.url
        cellFavButton.isHighlighted = isFav
    }
}
