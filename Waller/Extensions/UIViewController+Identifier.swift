//
//  UIViewControllerExtensions.swift
//  Waller
//
//  Created by Leonardo de Matos on 21/02/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func removeShadowImage(under view: UIView?) {
        guard let navBarView = view else { return }
        let imageView = findShadowImage(under: navBarView)
        imageView?.isHidden = true
    }
    
    fileprivate func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
}
