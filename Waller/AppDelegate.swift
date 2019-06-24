//
//  AppDelegate.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/10/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let testing = CommandLine.arguments.contains("--uitesting")
    
        configureCoordinator(for: testing)
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
    
    private func configureCoordinator(for testing: Bool) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = ApplicationCoordinator(window: window, testing: testing)
        self.window = window
    }
}
