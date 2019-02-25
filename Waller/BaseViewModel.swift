//
//  BaseViewModel.swift
//  Waller
//
//  Created by Leonardo de Matos on 25/06/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import RxCocoa

enum ViewModelViewState {
    case loading
    case refreshing
    case newPage
    case error
    case done
}
