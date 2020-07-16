//
//  UICollectionView.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static func register(for collectionView: UICollectionView)  {
        let cellIdentifier = identifier()
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
	
	static func identifier() -> String  {
        String(describing: self)
	}
}

