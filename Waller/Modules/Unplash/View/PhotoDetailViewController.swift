//
//  PhotoDetailViewController.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/3/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import Kingfisher
import Cartography

class PhotoDetailViewController: UIViewController {
    
    // MARK: Views

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return UIImageView()
    }()
    
    private lazy var backgroundBlurredImageView: UIImageView = {
        let blurredImageView = UIImageView()
        blurredImageView.contentMode = .scaleAspectFill
        blurredImageView.frame = view.frame
        blurredImageView.clipsToBounds = true
        return blurredImageView
    }()
    
    private lazy var visualEffectsView: UIVisualEffectView = {
       let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .dark)
        visualEffectView.frame = view.frame
        return visualEffectView
    }()
    
    var wallerPost: Photo?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        imageView.backgroundColor = .cyan
        
//        constrain(imageView) { image in
//            image.left == image.superview!.left
//            image.right == image.superview!.right
//            image.top == image.superview!.top
//            image.height == 500
//        }
//        self.view.bringSubviewToFront(imageView)
//
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
    }
    
    // MARK: - View Cnfiguration
    private func configureView() {
        view.backgroundColor = .white   
        imageView.clipsToBounds = true
        
        self.view?.addSubview(backgroundBlurredImageView)
        self.view?.addSubview(visualEffectsView)
//        self.view?.addSubview(imageView)
        
        imageView.backgroundColor = .cyan
    
        guard let urls = wallerPost?.urls else { return }
    
        imageView.lazyHighLoad(urls: urls)
        backgroundBlurredImageView.lazyHighLoad(urls: urls)
        
        UIView.animate(withDuration: 1) {
          self.visualEffectsView.alpha = 0
        }
    }
}
