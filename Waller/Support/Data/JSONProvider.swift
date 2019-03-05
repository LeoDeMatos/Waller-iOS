//
//  JSONProvider.swift
//  Waller
//
//  Created by Leonardo de Matos on 04/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation

class JSONProvider {
    
    static func provideJsonFor(path pathString: String) -> String {
        var json = "Not Found Json File"
        if let path = Bundle.main.path(forResource: pathString, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                json = String(data: data, encoding: .utf8) ?? json
            } catch {
                print(error)
            }
        }
        
        return json
    }
}
