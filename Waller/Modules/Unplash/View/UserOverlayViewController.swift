//
//  UserOverlayViewController.swift
//  Waller
//
//  Created by Leonardo de Matos on 05/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import Cartography
import Pulley

class UserOverlayViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.dark87
        return label
    }()
    
    private lazy var userNickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.blueGrey
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon-download")
        button.setImage(image,
                        for: .normal)
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon-heart")
        button.setImage(image,
                        for: .normal)
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    private lazy var relatedCollectionView: UICollectionView = {
        let staggeredLayout = StaggeredCollectionViewLayout()
//        staggeredLayout.delegate = self
        staggeredLayout.cellPadding = 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero,
                                                   collectionViewLayout: staggeredLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var collectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.dark87
        label.text = "Related photos"
        return label
    }()
    
    // MARK: - Declarations
    
    var viewModel: UserOverlayViewModel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindView()
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        self.view.backgroundColor = .white
        configureOverlayTopNotch()
        
        self.view.addSubview(userImageView)
        constrain(view, userImageView) { v, imageView in
            imageView.top == v.top + 36
            imageView.left == v.left + 30
            imageView.height == 40
            imageView.width == 40
        }
        
        self.view.addSubview(likeButton)
        constrain(view, likeButton, userImageView) { v, button, imageView in
            button.right == v.right - 30
            button.top == imageView.top
            button.bottom == imageView.bottom
            button.height == 40
            button.width == 40
        }
        
        self.view.addSubview(downloadButton)
        constrain(likeButton, downloadButton, userImageView) { lButton, button, imageView in
            button.right == lButton.left - 10
            button.top == imageView.top
            button.bottom == imageView.bottom
            button.height == 40
            button.width == 40
        }
        
        self.view.addSubview(userNameLabel)
        constrain(userImageView, userNameLabel, downloadButton) { imageView, label, button in
            label.top == imageView.top
            label.left == imageView.right + 10
            label.right == button.left + 10
        }
        
        self.view.addSubview(userNickNameLabel)
        constrain(userNameLabel, userNickNameLabel, downloadButton) { nLabel, label, button in
            label.top == nLabel.bottom
            label.left == nLabel.left
            label.right == button.left
        }
    }
    
    private func configureOverlayTopNotch() {
        let notchView = UIView()
        notchView.alpha = 0.30
        notchView.backgroundColor = UIColor.blueGrey
        notchView.layer.cornerRadius = 2.5
        notchView.layer.masksToBounds = true
        
        self.view.addSubview(notchView)
        constrain(view, notchView) { v, notch in
            notch.top == v.top + 10
            notch.height == 5
            notch.centerX == v.centerX
            notch.width == 50
        }
    }
    
    // MARK: - View Binding
    
    private func bindView() {
        let user = viewModel.user

        userImageView.load(url: user.profileImage)
        userNickNameLabel.text = user.username
        userNameLabel.text = user.name
    }
    
}

// MARK: - Pulley Drawer Delegate

extension UserOverlayViewController: PulleyDrawerViewControllerDelegate {
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 90 + bottomSafeArea
    }
}
