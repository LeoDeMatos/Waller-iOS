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
    
    // MARK: - Constructors
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Views

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return UIImageView()
    }()
    
    private lazy var backgroundBlurredImageView: UIImageView = {
        let blurredImageView = UIImageView()
        blurredImageView.contentMode = .scaleAspectFill
        blurredImageView.clipsToBounds = true
        blurredImageView.layer.cornerRadius = 10
        blurredImageView.layer.masksToBounds = true
        return blurredImageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: view.frame.width,
                                             height: view.frame.height)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
       let content = UIView()
        content.frame.size = CGSize(width: view.frame.width,
                                    height: view.frame.height)
        return content
    }()
    
    private lazy var visualEffectsView: UIVisualEffectView = {
       let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .dark)
        return visualEffectView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.color = .black
        return indicator
    }()
    
    // MARK: - Declarations
    var viewModel: PhotoDetailViewModel!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindView()
    }
    
    // MARK: - View Cnfiguration
    
    private func configureView() {
        self.navigationItem.title = "Stark"
        view.backgroundColor = .white   
        imageView.clipsToBounds = true
        
        self.view?.addSubview(scrollView)
        constrain(self.view, scrollView) { v, scroll in
            scroll.edges == v.edges
        }

        scrollView.addSubview(contentView)
        
        contentView.addSubview(activityIndicator)
        constrain(contentView, activityIndicator) { content, indicator in
            indicator.centerX == content.centerX
            indicator.top == content.top + 200
        }
        
        activityIndicator.startAnimating()
    
        contentView.addSubview(backgroundBlurredImageView)
        constrain(contentView, backgroundBlurredImageView) { v, img in
            img.top == v.top
            img.left == v.left
            img.right == v.right
            img.bottom == v.bottom
        }
        
        contentView.addSubview(visualEffectsView)
        constrain(contentView, visualEffectsView) { v, blurView in
            blurView.edges == v.edges
        }
    }
    
    // MARK: - View binding
    
    private func bindView() {
        let urls = viewModel.photo.urls
        imageView.lazyHighLoad(urls: urls)
        backgroundBlurredImageView.lazyHighLoad(urls: urls)
        
        UIView.animate(withDuration: 1) {
            self.visualEffectsView.alpha = 0
        }
    }
}
