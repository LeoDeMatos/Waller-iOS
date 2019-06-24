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
    
    private let unplashService: MoyaProvider<UnplashService>
    
    init(unplashService: MoyaProvider<UnplashService>) {
        self.unplashService = unplashService
    }
    
    var photos: [Photo]?
    var shots: [Shot]?
    
    func fetchPhotos(page: Int) -> Driver<Bool> {
        return unplashService.rx.request(.photos(page: page, perPage: 30)).map { response in
            self.photos = try response.map(to: [Photo].self)
            return true
            }.asDriver(onErrorJustReturn: false).debug()
    }
    
    func fetchPhotos(query: String, page: Int) -> Driver<Bool> {
        return unplashService.rx.request(.searchPhotos(query: query, page: page, perPage: 30)).map { [weak self] response in
            
            do {
                let result = try response.map(to: SearchResult.self)
                self?.photos = result.results
            } catch {
                print(error)
            }
            return true
            }.asDriver(onErrorJustReturn: false).debug()
    }
    
    func fetchNextPhotos(page: Int) -> Driver<[Photo]> {
        return unplashService.rx.request(.photos(page: page, perPage: 30)).map { response in
            let newPhotos = try response.map(to: [Photo].self)
            
            if self.photos == nil {
                self.photos = []
            }
            
            self.photos?.append(contentsOf: newPhotos)
            return newPhotos
            }.asDriver(onErrorJustReturn: []).debug()
    }
}
