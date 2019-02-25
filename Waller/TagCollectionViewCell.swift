//
//  TagCollectionViewCell.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/17/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func configure(tag: Tag) {
//        contentView.alpha = 0.5
//        contentView.backgroundColor = .lightGray
//        contentView.layer.cornerRadius = 15
//        tagLabel.text = tag.text
//    }
}
