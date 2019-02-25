//
//  BaseViewController.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/19/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var backgroundImage: UIImage?
    var backgroundShadowImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.titleTextAttributes =
//            [kCTForegroundColorAttributeName: UIColor.white,
//             kCTFontAttributeName: UIFont(name: "billabong", size: 36)!]
//        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Navigation Bar Handling
    
    func hideNavigationBar(){
        if backgroundImage == nil && backgroundShadowImage == nil{
            self.backgroundImage = self.navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default)
            self.backgroundShadowImage = self.navigationController?.navigationBar.shadowImage
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func restoreNavigationBar(){
        if backgroundImage != nil && backgroundShadowImage != nil{
            self.navigationController?.navigationBar.shadowImage = backgroundShadowImage
            self.navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
        }
    }
}
