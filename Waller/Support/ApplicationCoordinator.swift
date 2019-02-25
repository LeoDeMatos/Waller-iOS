//
//  ApplicationCoordinator.swift
//  Waller
//
//  Created by Leonardo de Matos on 14/07/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        
        rootViewController = UINavigationController()
        
        let navigationBar = rootViewController.navigationBar
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
    
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
    
    func start() {
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    
        let mainWallViewController = WLRMainWallViewController()
        rootViewController.pushViewController(mainWallViewController, animated: false)
    }
}
