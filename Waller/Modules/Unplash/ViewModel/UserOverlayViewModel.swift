//
//  UserOverlayViewModel.swift
//  Waller
//
//  Created by Leonardo de Matos on 05/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserOverlayViewModel {
    
    private let dataManager: PhotoDataManager
    var user: User
    
    init(dataManager:  PhotoDataManager, user: User) {
        self.dataManager = dataManager
        self.user = user
    }
    
    private let disposeBad = DisposeBag()
    
    let state = BehaviorRelay<ViewModelViewState>(value: .loading)
    
}
