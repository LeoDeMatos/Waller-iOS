//
//  ApplicationCoordinator.swift
//  Waller
//
//  Created by Leonardo de Matos on 14/07/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift
import RxCocoa

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let unplashService = MoyaProvider<UnplashService>(endpointClosure: endpointClosure)
    
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
        
        window.layer.cornerRadius = 5
        window.layer.masksToBounds = true
    }
    
    func start() {
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
        showWallViewController()
    }
    
    private func showWallViewController() {
        let wallViewController = WallViewController()
        let dataManager = PhotoDataManager(unplashService: unplashService)
        let viewModel = WallViewModel(dataManager: dataManager)
        wallViewController.viewModel = viewModel
        rootViewController.pushViewController(wallViewController, animated: false)
    }
}
