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

class UserDataManager: BaseDataManager<UnplashService> {
    
    func profile(userName: String) -> Driver<Result<User>> {
        return call(apiCall: .Profile(userName: userName))
    }
}
