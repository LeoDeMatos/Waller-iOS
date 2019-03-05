//
//  UnplashPhotoCoordinator.swift
//  Waller
//
//  Created by Leonardo de Matos on 04/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit
import Moya

protocol WallCoordinatorDelegate: class {
    func didSelectPhoto(photo: Photo)
    func getPreviewPhotoDetailViewController(photo: Photo) -> UIViewController
    func didCommitViewController()
}

class WallCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let provider: MoyaProvider<UnplashService>!
    private var photoDetailCoordinator: PhotoDetailCoordinator!
    
    init(navigationController: UINavigationController, provider: MoyaProvider<UnplashService>) {
        self.navigationController = navigationController
        self.provider = provider
    }
    
    func start() {
        showWallViewController()
    }
    
    // MARK: - Coordinator Navigation Actions
    
    private func showWallViewController() {
        let wallViewController = WallViewController()
        let dataManager = PhotoDataManager(unplashService: provider)
        let viewModel = WallViewModel(dataManager: dataManager)
        wallViewController.wallCoordinatorDelegate = self
        wallViewController.viewModel = viewModel
        navigationController.pushViewController(wallViewController, animated: false)
    }
}

// MARK: - WallCoordinator Delegate

extension WallCoordinator: WallCoordinatorDelegate {
    func didSelectPhoto(photo: Photo) {
        photoDetailCoordinator = PhotoDetailCoordinator(navigationController: navigationController,
                                                        provider: provider,
                                                        photo: photo)
        photoDetailCoordinator.start()
    }
    
    func getPreviewPhotoDetailViewController(photo: Photo) -> UIViewController {
        photoDetailCoordinator = PhotoDetailCoordinator(navigationController: navigationController,
                                                        provider: provider,
                                                        photo: photo)
        return photoDetailCoordinator.getPreviewViewController()
        
    }
    
    func didCommitViewController() {
        photoDetailCoordinator.start()
    }
}
