//
//  ViewController.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/10/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import Mapper
import AVFoundation
import Cartography

class WallViewController: UIViewController {
    
    // MARK: - Constructors
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Views
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var wallCollectionView: UICollectionView = {
        let staggeredLayout = StaggeredCollectionViewLayout()
        staggeredLayout.delegate = self
        staggeredLayout.cellPadding = 5
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero,
                                                   collectionViewLayout: staggeredLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: - Declaration
    
    private let disposeBag = DisposeBag()
    var viewModel: WallViewModel!
    
    // MARK: - View Lifecicle
    
    override func viewWillAppear(_ animated: Bool) {
        removeShadowImage(under: navigationController?.navigationBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
        registerForForceTouch()
    }
    
    fileprivate func configureView() {
        configureTableView()
        
        let backItem = UIBarButtonItem() 
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationItem.title = "Waller"
        
        configureUserView()
    }
    
    private func configureTableView() {
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.view.addSubview(wallCollectionView)
        constrain(self.view, wallCollectionView) { v, collection in
            collection.left == v.left
            collection.right == v.right
            collection.top == v.top
            collection.bottom == v.bottom
        }
        
        wallCollectionView.showsVerticalScrollIndicator = false
        wallCollectionView.register(WallCollectionViewCell.nib,
                                    forCellWithReuseIdentifier: WallCollectionViewCell.identifier)
        wallCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        wallCollectionView.delegate = self
        wallCollectionView.dataSource = self
    }
    
    private func configureUserView() {
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.addSubview(userImageView)
        constrain(navBar, userImageView) {nb, img in
            img.right == nb.right - 16
            img.bottom == nb.bottom - 10
            img.height == 40
            img.width == 40
        }
        
        userImageView.load(url: "https://yt3.ggpht.com/-JhG7CFvSUGo/AAAAAAAAAAI/AAAAAAAAAAA/lFU2rOckxfU/s108-c-k-no-mo-rj-c0xffffff/photo.jpg")
    }
    
    // MARK: - ViewModel Bindings
    
    private func configureViewModel() {
        bindViewModel()
        viewModel.fetechPhotos()
    }

    private func bindViewModel() {
        viewModel.state.asDriver().drive(onNext: { [weak self] (state) in
            switch state {
            case .done,
                 .newPage:
                let  staggeredLayout = self?.wallCollectionView.collectionViewLayout as! StaggeredCollectionViewLayout
                staggeredLayout.invalidateCachedAttr()
                self?.wallCollectionView.reloadData()
                
            default:
                self?.wallCollectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - ForceTouch Configuration
    
    private func registerForForceTouch() {
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: wallCollectionView)
        }
    }
}

// MARK: - CollectionView Delegate and DataSource
extension WallViewController: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let reachTarget = Int(self.view.frame.height * 0.10) * -1
        let contentScrollY = Int(scrollView.contentOffset.y)
        if contentScrollY == reachTarget {
            AudioServicesPlaySystemSound(SystemSoundID(1519))
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.userImageView.transform =   CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
        } else if Int(reachTarget * 2) ==  contentScrollY {
            AudioServicesPlaySystemSound(SystemSoundID(1520))
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.userImageView.transform =   CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        } else if contentScrollY > reachTarget {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.userImageView.transform =   CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.collectionView(_: collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let photo = viewModel.wallerPostForIndexPath(indexPath: indexPath) else { return CGSize() }
        
        let height = CGFloat(photo.height) * 0.05
        let width = (collectionView.bounds.size.width / 2) - 16.0//Double(photo.width) * 0.05
        
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: CGSize(width: width, height: height), insideRect: boundingRect)
        return rect.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = PhotoDetailViewController()
        viewController.wallerPost = viewModel.wallerPostForIndexPath(indexPath: indexPath)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - ForceTouch Extension

extension WallViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = wallCollectionView.indexPathForItem(at: location),
        let cell = wallCollectionView.cellForItem(at: indexPath) else { return nil }
        
                let previewViewController = PhotoDetailViewController()
        
                previewViewController.wallerPost = self.viewModel.wallerPostForIndexPath(indexPath: indexPath)
        
                let height = self.view.frame.height * 0.75
                previewViewController.preferredContentSize = CGSize(width: 0, height: height)
        
                if let cell = cell as? WallCollectionViewCell {
                    previewingContext.sourceRect = cell.frame
                }
    
        return previewViewController
    }
}

// MARK: - Staggered CollectionView Delegate

extension WallViewController: StaggeredCollectionViewLayoutDelegate {
    func heightForItemAt(indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel
            .wallerPostForIndexPath(indexPath: indexPath) else { return 0.0 }
        let actualHeight: CGFloat = CGFloat(item.height) * 0.05
        return CGFloat(actualHeight)
    }
}
