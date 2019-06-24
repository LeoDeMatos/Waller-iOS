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
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon-cog")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var wallCollectionView: UICollectionView = {
        let staggeredLayout = StaggeredCollectionViewLayout()
        staggeredLayout.delegate = self
        staggeredLayout.cellPadding = 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero,
                                                   collectionViewLayout: staggeredLayout)
        collectionView.backgroundColor = .green
        return collectionView
    }()
    
    // MARK: - Search Controller
    
    private lazy var searchContoller: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Find inspiration"
        controller.definesPresentationContext = true
        controller.searchBar.tintColor = .roseRed
    
        return controller
    }()
    
    // MARK: - Declaration
    
    private let disposeBag = DisposeBag()
    
    var viewModel: WallViewModel!
    weak var wallCoordinatorDelegate: WallCoordinatorDelegate?
    
    // MARK: - View Lifecicle
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navi
        
    }
    
    struct Joke: Decodable {
        let value: String
        let url: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = String(describing: WallViewController.self)
        
        view.backgroundColor = .red
        
        configureView()
        configureViewModel()
        registerForForceTouch()
    }
    
    private func getRandomJoke() {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if error != nil { return }
            
            guard let safeData = data else { return }
            
            var joke: Joke?
            
            do {
                let decoder = JSONDecoder()
                joke = try decoder.decode(Joke.self, from: safeData)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController.init(title: "New Chuck Joke",
                                                   message: joke?.value,
                                                   preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .destructive, handler: { (_) in
                    alert.dismiss(animated: true, completion: nil)
                })
                
                alert.addAction(action)
                
                self?.present(alert, animated: true, completion: nil)
            }
            }.resume()
    }
    
    // MARK: - View Configuration
    
    fileprivate func configureView() {
        view.backgroundColor = .white
        configureTableView()
        configureSearchBar()
        removeShadowImage(under: navigationController?.navigationBar)
        
        let backItem = UIBarButtonItem() 
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationItem.title = "Waller"
    
    }
    
    private func configureTableView() {
        automaticallyAdjustsScrollViewInsets = true
        
        view.addSubview(wallCollectionView)
        constrain(self.view, wallCollectionView) { v, collection in
            collection.left == v.left + 6
            collection.right == v.right
            collection.top == v.top
            collection.bottom == v.bottom
        }
        
        wallCollectionView.showsVerticalScrollIndicator = false
        wallCollectionView.register(WallCollectionViewCell.nib,
                                    forCellWithReuseIdentifier: WallCollectionViewCell.identifier)
        wallCollectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        wallCollectionView.delegate = self
        wallCollectionView.dataSource = self
    }
    
    private func configureSettingButton() {
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.addSubview(settingButton)
        constrain(navBar, settingButton) {nb, img in
            img.right == nb.right - 16
            img.bottom == nb.bottom - 16
            img.height == 30
            img.width == 30
        }
    }
    
    // MARK: - Configure Search
    
    private func configureSearchBar() {
        if #available(iOS 11, *) {
            self.navigationItem.searchController = searchContoller
        } else {
            // TODO: Fall back
        }
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
    
    // MARK: - PullToReach Configuration
    
    private func configureSimpleTemporaryPullToReach(scrolledOffsetY: CGFloat) {
        let height = self.view.frame.height * -1
        let firstTreshold = (Int(height * 0.10), Int(height * 0.15))
        let secondTreshold = (Int(height * 0.15), Int(height * 0.20))
        let contentScrollY = Int(scrolledOffsetY)
        
        if contentScrollY == firstTreshold.0 {
            AudioServicesPlaySystemSound(SystemSoundID(1519))
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.settingButton.transform =   CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
        } else if contentScrollY == secondTreshold.0 || contentScrollY == secondTreshold.1 {
            AudioServicesPlaySystemSound(SystemSoundID(1520))
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.settingButton.transform =   CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        } else if contentScrollY > firstTreshold.0 {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.settingButton.transform =   CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

// MARK: - CollectionView Delegate and DataSource

extension WallViewController: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       configureSimpleTemporaryPullToReach(scrolledOffsetY: scrollView.contentOffset.y)
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
        guard let photo = viewModel.wallerPostForIndexPath(indexPath: indexPath) else { return }
        wallCoordinatorDelegate?.didSelectPhoto(photo: photo)
    }
}

// MARK: - ForceTouch Extension

extension WallViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           commit viewControllerToCommit: UIViewController) {
        wallCoordinatorDelegate?.didCommitViewController()
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = wallCollectionView.indexPathForItem(at: location),
        let cell = wallCollectionView.cellForItem(at: indexPath) else { return nil }
        
        guard let photo = self.viewModel.wallerPostForIndexPath(indexPath: indexPath) else { return nil }
        let previewViewController = wallCoordinatorDelegate?.getPreviewPhotoDetailViewController(photo: photo)
        let height = self.view.frame.height * 0.75
        previewViewController?.preferredContentSize = CGSize(width: 0, height: height)
        
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

// MARK: - Search Controller

extension WallViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        viewModel.fetechPhotos(query: query)
    }
}

import SwiftUI
import Moya

struct WallIntegration: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<WallIntegration>) -> WallViewController {
        let wallViewController = WallViewController()
        let dataManager = PhotoDataManager(unplashService: MoyaProvider<UnplashService>(endpointClosure: endpointClosure))
        let viewModel = WallViewModel(dataManager: dataManager)
        wallViewController.viewModel = viewModel
        return wallViewController
    }
    
    func updateUIViewController(_ uiViewController: WallViewController, context: UIViewControllerRepresentableContext<WallIntegration>) {
        
    }
}

struct WallPreview: PreviewProvider {
    static var previews: WallIntegration {
        return WallIntegration()
    }
}
