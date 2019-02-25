//
//  WLRUserDataManager.swift
//  Waller
//
//  Created by Leonardo de Matos on 07/04/18.
//  Copyright © 2018 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa
import Mapper
import Moya_ModelMapper

class WLRUserDataManager {
    
    func profile(userName: String) -> Driver<WLRUser?> {
        return unplashService.rx.request(.Profile(userName: userName)).map { response in
            return try response.map(to: WLRUser.self)
            }.asDriver(onErrorJustReturn: nil).debug()
    }
}
