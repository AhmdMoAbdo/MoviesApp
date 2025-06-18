//
//  HomeCellConfigurable.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

protocol HomeCellConfigurable: UICollectionViewCell {
    func setupCell(
        with movie: Movie,
        isFavorite: Bool,
        onTappingFavoriteIcon: @escaping (Bool) -> Void
    )
    
    func updateFavoriteState(_ isFavorite: Bool)
}
