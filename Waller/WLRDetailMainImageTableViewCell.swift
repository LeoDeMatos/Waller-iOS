//
//  DetailMainImageTableViewCell.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/17/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import Kingfisher

class WLRDetailMainImageTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(wallerPost: WLRPhoto) {
        if let highImage = wallerPost.urls.full {
            self.mainImage.kf.setImage(with: URL(string: highImage))
        }
    }
}
