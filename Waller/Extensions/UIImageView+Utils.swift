//
//  UIImageViewExtensions.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/17/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func toCircular() {
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .lightGray
        self.layer.masksToBounds = true
    }
    
    func load(url: String) {
    
        if let resource = URL(string: url) {
            self.kf.setImage(with: resource, options: [.transition(ImageTransition.flipFromBottom(1))])
        }
    }
    
    func load(url: WallURL) {
        if let image = url.small, let url = URL(string: image) {
            let resource = ImageResource(downloadURL: url, cacheKey: image)
            self.kf.setImage(with: resource,
                             options: [.transition(ImageTransition.flipFromBottom(1))])
        }
    }
    
    func lazyHighLoad(urls: WallURL) {
        if let image = urls.small, let high = urls.full, let url = URL(string: high) {
            let resource = ImageResource(downloadURL: url, cacheKey: image)
            self.kf.setImage(with: resource,
                             options: [.transition(ImageTransition.flipFromBottom(1))])
            self.kf.setImage(with: URL(string: urls.full),
                             options: [.transition(ImageTransition.flipFromBottom(1))])
        }
    }
}
