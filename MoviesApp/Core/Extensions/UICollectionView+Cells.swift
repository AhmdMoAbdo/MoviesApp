//
//  UICollectionView+Cells.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

// MARK: - Ease handling collection view cells registeration and dequeueing
public extension UICollectionView {
    /// Cell Registeration
    func register<T: UICollectionViewCell>(_ name: T.Type) {
        register(
            UINib(
                nibName: String(describing: name.self),
                bundle: nil
            ),
            forCellWithReuseIdentifier: String(describing: name.self)
        )
    }
    
    /// Cell Dequeueing
    func dequeueReusableCell<T: UICollectionViewCell>(_ name: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(
            withReuseIdentifier: String(describing: name.self),
            for: indexPath
        ) as? T
    }
}
