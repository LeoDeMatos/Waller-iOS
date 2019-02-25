//
//  UserInfoTableViewCell.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/17/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import Kingfisher

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userSocialLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.toCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(wallerUser: WLRUser) {
        userNameLabel.text = wallerUser.name
        userSocialLabel.text = "@\(wallerUser.username)"
        userImageView.load(url: wallerUser.profileImage)
    }
    
}
