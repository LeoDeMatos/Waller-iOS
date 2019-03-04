//
//  Shot.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/15/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Mapper

struct Shot: Mappable {
    var id: Int
    let image: String
    let highImage: String?
    let tags: [String]
    let user: ShotUser?
    
    init(map: Mapper) throws {
        self.id = try map.from("id")
        self.image = try map.from("images.normal")
        self.highImage = map.optionalFrom("images.hidpi")
        self.tags = try map.from("tags")
        self.user = map.optionalFrom("user")
    }
}

struct ShotUser: Mappable {
    let id: Int
    let name: String
    let bio: String?
    let username: String
    let avatarUrl: String
    
    init(map: Mapper) throws {
        self.id = try map.from("id")
        self.name = try map.from("name")
        self.username = try map.from("username")
        self.avatarUrl = try map.from("avatar_url")
        self.bio = map.optionalFrom("bio")
    }
}
