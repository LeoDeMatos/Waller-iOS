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
        navigationController.pushViewController(photoDetailViewController, animated: true)
    }
    
    func getPreviewViewController() -> UIViewController {
        let photoDetailViewController = PhotoDetailViewController()
        let photoDataManager = PhotoDataManager(unplashService: provider)
        let viewModel = PhotoDetailViewModel(dataManager: photoDataManager, photo: photo)
        photoDetailViewController.viewModel = viewModel
        return photoDetailViewController
    }
}
