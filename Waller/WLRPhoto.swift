//
//  WallResponse.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/10/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Mapper

struct WLRPhoto: Mappable {
    let urls: WallURL
    let user: WLRUser?
    let height: Int
    let width: Int
    
    init(map: Mapper) throws {
        try urls = map.from("urls")
        user = map.optionalFrom("user")
        try width = map.from("width")
        try height = map.from("height")
    }
}

struct WallURL: Mappable {
    let raw: String!
    let regular: String!
    let full: String!
    let small: String!
   
    init(map: Mapper) throws {
        try raw = map.from("raw")
        try regular = map.from("regular")
        try full = map.from("full")
        try small = map.from("small")
    }
}
