//
//  PhotoDetailCoordinator.swift
//  Waller
//
//  Created by Leonardo de Matos on 04/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import Moya
import UIKit
import Pulley

class PhotoDetailCoordinator: Coordinator {
    
    private let navigationController: UINavigationController!
    private let provider: MoyaProvider<UnplashService>
    private let photo: Photo
    
    init(navigationController: UINavigationController,
         provider: MoyaProvider<UnplashService>,
         photo: Photo) {
        self.navigationController = navigationController
        self.provider = provider
        self.photo = photo
    }
    
    func start() {
        let photoDetailViewController = PhotoDetailViewController()
        let photoDataManager = PhotoDataManager(unplashService: provider)
        let viewModel = PhotoDetailViewModel(dataManager: photoDataManager, photo: photo)
        photoDetailViewController.viewModel = viewModel
        
        let targetViewController: UIViewController
        
        if let user = photo.user {
            let overlayViewController = UserOverlayViewController()
            let overlayViewModel = UserOverlayViewModel(dataManager: photoDataManager, user: user)
            overlayViewController.viewModel = overlayViewModel
        
            let pulleyViewController = PulleyViewController(contentViewController: photoDetailViewController,
                                                            drawerViewController: overlayViewController)
            
            targetViewController = pulleyViewController
        } else {
            targetViewController = photoDetailViewController
        }
        
        if photo.likes == 0 {
            targetViewController.navigationItem.title = "\(photo.likes) Likes 🥶"
        } else {
            targetViewController.navigationItem.title = "\(photo.likes) Likes 😍"
        }
        
        navigationController.pushViewController(targetViewController, animated: true)
    }
    
    func getPreviewViewController() -> UIViewController {
        let photoDetailViewController = PhotoDetailViewController()
        let photoDataManager = PhotoDataManager(unplashService: provider)
        let viewModel = PhotoDetailViewModel(dataManager: photoDataManager, photo: photo)
        photoDetailViewController.viewModel = viewModel
        return photoDetailViewController
    }
    
    // MARK: - Pulley Configuration

}
