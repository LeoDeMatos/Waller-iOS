//
//  Result.swift
//  Waller
//
//  Created by Leonardo de Matos on 03/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Mapper

struct Result<Content> {
    
    init(content: Content) {
        self.content = content
    }
    
    init() {}
    
    var error: String? = nil
    var content: Content? = nil
    var isSuccessFull: Bool {
        return content != nil
    }
}
