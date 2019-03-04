//
//  ScrollViewPullToReachDelegate.swift
//  Waller
//
//  Created by Leonardo de Matos on 04/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit

protocol PullToReachDelegate {
    func actionTriggered(position: Int)
}

class PullToReachManager {

    typealias TresholdPosition = Int
    
//    weak var delegate: PullToReachDelegate?
    
    // MARK: - Declarations
    
    private let actionsTreshold: [Int]
    
    init(actionsTreshold: [Int]) {
        self.actionsTreshold = actionsTreshold.sorted()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let actionPosition = calculateTreshold(scrollView: scrollView) else { return }
//        delegate?.actionTriggered(position: actionPosition)
    }
    
    private func calculateTreshold(scrollView: UIScrollView) -> TresholdPosition? {
        let contentScrollY = Int(scrollView.contentOffset.y)
        
        var actualTreshold: TresholdPosition?
      
        actionsTreshold.enumerated().forEach { (index: Int, treshold: Int) in
            if treshold > contentScrollY {
                actualTreshold = index
            }
        }
        return actualTreshold
    }
}
