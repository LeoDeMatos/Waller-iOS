//
//  WLRUser.swift
//  Waller
//
//  Created by Leonardo de Matos on 07/04/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Mapper

struct WLRUser: Mappable{
    let id: String
    let username: String
    let name: String
    let bio: String
    let profileImage: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try username = map.from("username")
        try name = map.from("name")
        try bio = map.from("bio")
        try profileImage = map.from("profile_image.medium")
    }
}
