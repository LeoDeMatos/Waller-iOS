//
//  PhotoDataManager.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/26/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa
import Mapper
import Moya_ModelMapper

class PhotoDataManager {
    
    var photos: [WLRPhoto]?
    var shots: [Shot]?
    
    func fetchPhotos(page: Int) -> Driver<Bool> {
        return unplashService.rx.request(.Photos(page: page, perPage: 30)).map { response in
            self.photos = try response.map(to: [WLRPhoto].self)
            return true
            }.asDriver(onErrorJustReturn: false).debug()
    }
    
    func fetchNextPhotos(page: Int) -> Driver<[WLRPhoto]> {
        return unplashService.rx.request(.Photos(page: page, perPage: 30)).map { response in
            let newPhotos = try response.map(to: [WLRPhoto].self)
            
            if self.photos == nil {
                self.photos = []
            }
            
            self.photos?.append(contentsOf: newPhotos)
            return newPhotos
            }.asDriver(onErrorJustReturn: []).debug()
    }
}
