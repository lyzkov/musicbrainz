//
//  UICollectionView.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeCell<T: UICollectionViewCell>(cellClass: T.Type, at indexPath: IndexPath) -> T {
        let reusableID = (cellClass as UICollectionViewCell.Type).indentifire
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: reusableID, for: indexPath) as? T else {
            fatalError("Please check your cell's ID is same as it's class name")
        }
        return cell
    }
    
    func dequeResulableView<T: UICollectionReusableView>(kind: String, viewClass: T.Type, at indexPath: IndexPath) -> T {
        let reusableID = (viewClass as UICollectionReusableView.Type).indentifire
        
        guard let view = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: reusableID, for: indexPath) as? T else {
            fatalError("Please check your cell's ID is same as it's class name")
        }
        return view
    }
}
