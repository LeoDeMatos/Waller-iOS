//
//  SearchResult.swift
//  Waller
//
//  Created by Leonardo de Matos on 02/04/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Mapper

struct SearchResult: Mappable {
    
    let total: Int
    let numberOfPages: Int
    let results: [Photo]
    
    init(map: Mapper) throws {
        total = try map.from("total")
        numberOfPages = try map.from("total_pages")
        results = try map.from("results")
    }
    
}
