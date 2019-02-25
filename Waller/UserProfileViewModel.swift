//
//  UserProfilePresenter.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/18/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Mapper
import Foundation
import RxSwift

class WLRUserProfileViewModel {
    
    private let userView: UserProfileView!
    private var user: WLRUser!
    
    private let disposeBag = DisposeBag()
    private let photoDataManager = PhotoDataManager()
    private let userDataManager = WLRUserDataManager()
    
    private var posts: [WLRPhoto]?
    private var currentPage = 1
    
    init(view: UserProfileView, user: WLRUser) {
        self.userView = view
        self.user = user
    }
    
    func presentPosts() {
        presentPhotos(userName: user.username)
    }
    
    private func presentPhotos(userName: String) {
        userDataManager.profile(userName: userName).drive(onNext: { (data) in
            
            if let user = data {
                self.user = user
            }
            self.userView.onUsersProfileLoaded()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func countOfItems() -> Int {
        return posts?.count ?? 0
    }
    
    func wallerPostForIndexPath(indexPath: IndexPath) -> WLRPhoto? {
        guard let object = posts?[indexPath.row] else {return nil}
        return object
    }
    
    // MARK: - Setters
    func setLocalLoadedPost(post: WLRPhoto) {
        posts = []
        posts?.append(post)
    }
    
}
