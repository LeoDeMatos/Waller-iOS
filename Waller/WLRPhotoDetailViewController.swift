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

class WLRPhotoDetailViewController: UIViewController {
    
    private var detailTableView: UITableView!
    
    private var shouldRestore = true
    private var isHidden = false
    private var constantHeight = 1
    private var imageView: UIImageView!
    private var imageViewHeight: Int = 200
    private var profileCellHeight: Int = 0
    
    var wallerPost: WLRPhoto?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        detailTableView = UITableView()
        imageView = UIImageView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.isHidden = false
        configureView()
        setupTableView()
        
        imageView.backgroundColor = .cyan
        
        constrain(imageView) { image in
            image.left == image.superview!.left
            image.right == image.superview!.right
            image.top == image.superview!.top
            image.height == 220
        }
        self.view.bringSubviewToFront(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - View Cnfiguration
    private func configureView() {
        self.view?.addSubview(detailTableView)
        
        constrain(detailTableView) { table in
            table.edges == table.superview!.edges
        }
                
        imageView.clipsToBounds = true
        self.view?.addSubview(imageView)
        imageView.backgroundColor = .cyan
    
        guard let urls = wallerPost?.urls else { return }
    
        imageView.lazyHighLoad(urls: urls)
    }
    
    // MARK: - TableView Setup
    fileprivate func setupTableView() {
    
        self.view.addSubview(detailTableView)
        
        detailTableView.register(UserInfoTableViewCell.nib, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
        
        detailTableView.register(WLRDetailMainImageTableViewCell.nib,
                                 forCellReuseIdentifier: WLRDetailMainImageTableViewCell.identifier)
        
        detailTableView.register(TagsContainerTableViewCell.nib,
                                 forCellReuseIdentifier: TagsContainerTableViewCell.identifier)
        
        detailTableView.register(SocialStatsTableViewCell.nib,
                                 forCellReuseIdentifier: SocialStatsTableViewCell.identifier)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = .clear
        
        detailTableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Photo"
        self.navigationItem.backBarButtonItem = backItem
    }
    
    @objc private func didLongPressPhoto() {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }

    // MARK: Navigation Bar Handling
    
    var backgroundImage: UIImage?
    var backgroundShadowImage: UIImage?
    
    fileprivate func hideNavigationBar() {
        if backgroundImage == nil && backgroundShadowImage == nil {
            self.backgroundImage = self.navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default)
            self.backgroundShadowImage = self.navigationController?.navigationBar.shadowImage
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.isHidden = true
    }
    
    fileprivate func restoreNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = backgroundShadowImage
        self.navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
        self.isHidden = false
    }
    // MARK: TableView
    fileprivate func heightForRowAtIndexPath(indexPath: IndexPath) -> Int {
        if indexPath.row == 0 {
            return imageViewHeight
        } else if indexPath.row == 1 {
            return profileCellHeight
        } else if indexPath.row == 2 {
            return 70
        } else {
            return 60
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        shouldRestore = false
        if let vc = segue.destination as? WLRUserProfileViewController {
            if let post = wallerPost, let user = wallerPost?.user {
                vc.viewModel = WLRUserProfileViewModel(view: vc, user: user)
                vc.viewModel.setLocalLoadedPost(post: post)
            }
        }
    }
}
extension WLRPhotoDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WLRDetailMainImageTableViewCell.identifier)
                as! WLRDetailMainImageTableViewCell
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TagsContainerTableViewCell.identifier)
                as! TagsContainerTableViewCell
            return cell
        }
        
        if indexPath.row == 3 {
            return tableView.dequeueReusableCell(withIdentifier: SocialStatsTableViewCell.identifier)
                as! SocialStatsTableViewCell
        }
        
        let userCell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier)
            as! UserInfoTableViewCell
        if let user = wallerPost?.user {
            userCell.configure(wallerUser: user)
        }
        return userCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.heightForRowAtIndexPath(indexPath: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "presentUserProfile", sender: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y < 0.0 {
            var transform = CGAffineTransform.init(translationX: 0,
                                                   y: offset.y)
            let scaleFactor = 1 + (-1 * offset.y /
                (CGFloat(imageView.frame.height) / 2))
            transform = transform.scaledBy(x: scaleFactor, y: scaleFactor)
           imageView.transform = transform
        } else {
            imageView.transform = .identity
        }
    }
}
