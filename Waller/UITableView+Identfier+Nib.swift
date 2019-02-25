//
//  UITableViewExtensions.swift
//  Waller
//
//  Created by Leonardo de Matos on 18/02/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
}
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
}
