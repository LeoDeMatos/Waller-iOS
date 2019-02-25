//
//  WallPresenter.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/4/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Mapper
import Foundation
import RxSwift
import RxCocoa
import UIKit

class WLRMainWallViewModel {
    
    private let disposeBag = DisposeBag()
    private let photoDataManager = PhotoDataManager()
    private var currentPage = 1
    private var isFetching = false

    let state = BehaviorRelay<ViewModelViewState>(value: .loading)
    
    func fetechPhotos() {
        state.accept(.loading)
        
        photoDataManager.fetchPhotos(page: self.currentPage)
            .drive(onNext: { (_) in
                self.state.accept(.newPage)
            }).disposed(by: disposeBag)
    }
    
    func presentNextPage() {
        currentPage += 1
        isFetching = true
        
        self.photoDataManager.fetchNextPhotos(page: self.currentPage)
            .drive(onNext: { (_) in
                    self.state.accept(.newPage)
            }, onCompleted: {self.isFetching = false}, onDisposed: nil).disposed(by: disposeBag)
        
    }
    
    func numberOfItems() -> Int {
        return photoDataManager.photos?.count ?? 0
    }
    
    func wallerPostForIndexPath(indexPath: IndexPath) -> WLRPhoto? {
        if let post = photoDataManager.photos?[indexPath.row] {
            return post
        } else {
            return nil
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallCollectionViewCell.identifier, for: indexPath) as! WallCollectionViewCell
        
        fetchItemsIfNeeded(indexPath: indexPath)
        
        cell.bindBackgrounColorFor(indexPath: indexPath)
        cell.bind(wallResponse: wallerPostForIndexPath(indexPath: indexPath)!)
        return cell
    }
    
    //MARK: - Data Flow
    private func fetchItemsIfNeeded(indexPath: IndexPath){
        if indexPath.row == numberOfItems() - 2{
            if !isFetching {
                presentNextPage()
            }
        }
    }
}
