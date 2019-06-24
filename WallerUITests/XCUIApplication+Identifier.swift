//
//  XCUIApplication+Identifier.swift
//  WallerUITests
//
//  Created by Leonardo de Matos on 10/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication {
    var isShowingWallViewController: Bool {
        return otherElements["WallViewController"].exists
    }
}
