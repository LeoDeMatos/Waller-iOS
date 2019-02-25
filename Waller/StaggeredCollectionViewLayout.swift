//
//  StaggeredCollectionViewLayout.swift
//  Waller
//
//  Created by Leonardo de Matos on 10/02/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit

protocol StaggeredCollectionViewLayoutDelegate: class {
    func heightForItemAt(indexPath: IndexPath) -> CGFloat
}

class StaggeredCollectionViewLayout: UICollectionViewLayout {
    
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        let actualWidth = collectionView!.bounds.width - (insets.left + insets.right)
        return actualWidth
    }
    
    weak var delegate: StaggeredCollectionViewLayoutDelegate!
    var numberOfColumns: CGFloat = 2
    var cellPadding: CGFloat = 2
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        if attributesCache.isEmpty {
            let columnWidth = contentWidth / numberOfColumns
            var xOffsets = [CGFloat]()
            for column in 0 ..< Int(numberOfColumns) {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                let photoHeight: CGFloat = delegate.heightForItemAt(indexPath: indexPath)
                let width = columnWidth - cellPadding * 2
                let height = cellPadding + photoHeight + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: width, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributesCache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                
                yOffsets[column] = yOffsets[column] + height
                
                if column >= Int((numberOfColumns - 1)) {
                    column = 0
                } else {
                    column += 1
                }
            }
        }
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        if attributesCache.isEmpty {
            let columnWidth = contentWidth / numberOfColumns
            var xOffsets = [CGFloat]()
            for column in 0 ..< Int(numberOfColumns) {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                let photoHeight: CGFloat = delegate.heightForItemAt(indexPath: indexPath)
                let width = columnWidth - cellPadding * 2
                let height = cellPadding + photoHeight + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: width, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributesCache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                
                yOffsets[column] = yOffsets[column] + height
                
                if column >= Int((numberOfColumns - 1)) {
                    column = 0
                } else {
                    column += 1
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return  CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attr in attributesCache {
            if attr.frame.intersects(rect) {
                layoutAttributes.append(attr)
            }
        }
        return layoutAttributes
    }
    
    func invalidateCachedAttr() {
        attributesCache = []
    }
}
