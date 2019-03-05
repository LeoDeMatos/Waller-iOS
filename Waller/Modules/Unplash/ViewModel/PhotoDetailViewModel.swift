//
//  PhotoDetailViewModel.swift
//  Waller
//
//  Created by Leonardo de Matos on 04/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PhotoDetailViewModel {
    
    private let dataManager: PhotoDataManager
    let photo: Photo
    
    init(dataManager: PhotoDataManager, photo: Photo) {
        self.dataManager = dataManager
        self.photo = photo
    }
    
    private let disposeBad = DisposeBag()
    
    let state = BehaviorRelay<ViewModelViewState>(value: .loading)
    
}
