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
    var stubbingProvider = MoyaProvider<UnplashService>(stubClosure: MoyaProvider.immediatelyStub)
    
    private let wallCoordinator: WallCoordinator!
    
    init(window: UIWindow, testing: Bool) {
        self.window = window
        
        rootViewController = UINavigationController()
        
        let navigationBar = rootViewController.navigationBar
        navigationBar.isTranslucent = false
        
        ThemeManager.shared.setNewThemeMode(mode: .light)
        let currentMode = ThemeManager.shared.currentThemeMode
        
        navigationBar.barTintColor = currentMode == .light ? .white : .black
        navigationBar.tintColor =  currentMode == .light ? .black : .white
    
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
        
        window.layer.cornerRadius = 5
        window.layer.masksToBounds = true
        
        let provider = testing ? stubbingProvider : unplashService
        wallCoordinator = WallCoordinator(navigationController: rootViewController,
                                                          provider: provider)
    }
    
    func start() {
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
        wallCoordinator.start()
    }
}
