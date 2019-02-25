//
//  UserDetailCollectionViewCell.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/17/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit

class UserDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userSocialLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            userMainImageView.toCircular()
    }
    
    func configure(user: WLRUser) {
        
        do {
            self.userNameLabel.attributedText = try user.name.convertHtmlSymbols()
        }catch {
            print(error)
        }
    
        self.userMainImageView.load(url: user.profileImage)
        self.userDescriptionLabel.text = user.bio
    }
}
