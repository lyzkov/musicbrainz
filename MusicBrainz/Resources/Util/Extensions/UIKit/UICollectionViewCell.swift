//
//  UICollectionViewCell.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
import UIKit

//extension UICollectionViewCell {
//    override class var indentifire: String {
//        return "\(self)"
//    }
//    static func instantiateAsReusable(inCollectionView collectionView: UICollectionView,
//                                      at indexPath: IndexPath) -> Self {
//        return collectionView.dequeCell(cellClass: self, at: indexPath)
//    }
//}

extension UICollectionReusableView {
    class var indentifire: String {
        return "\(self)"
    }
    static func dequeue(kind: String, inCollectionView collectionView: UICollectionView,
                        at indexPath: IndexPath) -> Self {
        return collectionView.dequeResulableView(kind: kind, viewClass: self, at: indexPath)
    }
}
