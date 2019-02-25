//
//  UserProfileViewController.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/18/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit

class WLRUserProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: WLRUserProfileViewModel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        viewModel?.presentPosts()
        
        setupCollectionView()
        
        bindProfile()
    }
    
    // MARK: View configuration
    
    fileprivate func setupCollectionView() {
        self.collectionView.register(WallCollectionViewCell.nib,
                                     forCellWithReuseIdentifier: WallCollectionViewCell.identifier)
    
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - User Profile Binding
    private func bindProfile() {
    
    }

}
extension WLRUserProfileViewController: UserProfileView {
    func onUsersProfileLoaded() {
        self.collectionView.reloadData()
    }
}

extension WLRUserProfileViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: WallCollectionViewCell.identifier,
                                 for: indexPath) as! WallCollectionViewCell
        
        if let post = viewModel.wallerPostForIndexPath(indexPath: indexPath) {
            cell.bind(wallResponse: post)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.view.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
