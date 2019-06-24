//
//  ThemeManager.swift
//  Waller
//
//  Created by Leonardo de Matos on 31/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation

enum ThemeMode: String {
    case light
    case dark
}

class ThemeManager {
    
    static var shared: ThemeManager = {
        return ThemeManager()
    }()
    
    lazy var currentThemeMode: ThemeMode = {
        let theme = UserDefaults.standard.string(forKey: String(describing: ThemeMode.self))
        return ThemeMode(rawValue: theme ?? "light") ?? .light
    }()
    
    func setNewThemeMode(mode: ThemeMode) {
        UserDefaults.standard.set(mode.rawValue, forKey: String(describing: ThemeMode.self))
        currentThemeMode = mode
    }

    
}
