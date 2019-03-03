//
//  BasaDataManager.swift
//  Waller
//
//  Created by Leonardo de Matos on 03/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Mapper

class BaseDataManager<API: TargetType> {
    
    private let provider: MoyaProvider<API>
    
    init(provider: MoyaProvider<API>) {
        self.provider = provider
    }
    
    func call<T: Mappable>(apiCall: API) -> Driver<Result<T>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<T> in
                let responseData = try response.map(to: T.self)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
    
    func call<T: Mappable>(apiCall: API) -> Driver<Result<[T]>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<[T]> in
                let responseData = try response.map(to: [T].self)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
    
    func call(apiCall: API) -> Driver<Result<[String]>> {
        let newDriver = provider.rx.request(apiCall)
            .map { response -> Result<[String]> in
                let decoder = JSONDecoder()
                let responseData = try decoder.decode([String].self, from: response.data)
                let result = Result(content: responseData)
                return result
            }.asDriver(onErrorJustReturn: Result()).debug()
        
        return newDriver
    }
}

