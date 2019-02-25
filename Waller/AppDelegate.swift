//
//  AppDelegate.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/10/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

let unplashService = MoyaProvider<UnplashService>(endpointClosure: endpointClosure)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureCoordinator()
        applicationCoordinator?.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    // MARK: - Coordinator Configuration
    
    private func configureCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = ApplicationCoordinator(window: window)
        
        self.window = window
        
    }


    // Trash can
    /*
     UINavigationBar.appearance().isTranslucent = true
     UINavigationBar.appearance().tintColor = .roseRed
     
     if #available(iOS 11.0, *) {
     UINavigationBar.appearance().largeTitleTextAttributes =
     [NSAttributedString.Key.foregroundColor: UIColor.black,
     NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
     }
     */
}
