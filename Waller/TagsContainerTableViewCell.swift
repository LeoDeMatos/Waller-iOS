//
//  TagsContainerTableViewCell.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 6/17/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import UIKit

class TagsContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    var wallerPost: WLRPhoto?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(wallerPost: WLRPhoto){
        self.wallerPost = wallerPost
        self.tagsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.tagsCollectionView.register(UINib.init(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
//        self.tagsCollectionView.delegate = self
//        self.tagsCollectionView.dataSource = self
    }
}

//extension TagsContainerTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return wallerPost!.tags.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
//        cell.configure(tag: wallerPost!.tags[indexPath.row])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize.init(width: 100, height: 30)
//    }
//
//}

