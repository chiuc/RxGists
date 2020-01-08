//
//  HomeTableViewCell.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import UIKit
//import AlamofireImage
import Kingfisher

protocol FavButtonsDelegate{
    func onFavTapped(at index:IndexPath)
}

class HomeTableViewCell: UITableViewCell {
    var delegate:FavButtonsDelegate!
    var indexPath:IndexPath!
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellIDLabel: UILabel!
    @IBOutlet weak var cellURLLabel: UILabel!
    @IBOutlet weak var cellFileTextView: UITextView!
    @IBOutlet weak var cellFavButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.layer.masksToBounds = true
        cellImageView.layer.borderColor = UIColor.lightGray.cgColor
        cellImageView.layer.borderWidth = 1.0 / UIScreen.main.scale
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.kf.cancelDownloadTask()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.layer.cornerRadius = cellImageView.frame.width / 2.0
    }
    
    @IBAction func onFavClick() {
        self.delegate?.onFavTapped(at: indexPath)
    }
    
    func configure(with item: HomeViewItemInterface, isFav: Bool) {
        let name = item.name!
        let file = item.files?.first?.key;
        cellIDLabel.text = "\(name)/\(file!)"

        cellURLLabel.text = item.url
        var fileStr = ""
        var index = 0
        for (key, _) in item.files! {
            if (index == 5) {
                return
            }
            if (fileStr == "") {
                fileStr = key
            } else {
                fileStr = String(format: "%@ \n%@", fileStr, key)
            }
            index+=1
        }
        cellFileTextView.text = fileStr
        if let url = item.imageUrl {
            cellImageView.kf.setImage(with: url)
        } else {
            cellImageView.image = #imageLiteral(resourceName: "image-placeholder")
        }
        cellFavButton.isHighlighted = isFav
    }

}
