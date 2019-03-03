//
//  WallCollectionViewCell.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/10/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import Kingfisher

class WallCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wallImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        wallImage.layer.cornerRadius = 15
        wallImage.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func bind(wallResponse: Photo) {
        wallImage.load(url: wallResponse.urls)
    }
    
    func bindBackgrounColorFor(indexPath: IndexPath) {
        contentView.backgroundColor = .clear//indexPath.row % 5 == 0 ? .white : UIColor.wlrGray
    }
}
