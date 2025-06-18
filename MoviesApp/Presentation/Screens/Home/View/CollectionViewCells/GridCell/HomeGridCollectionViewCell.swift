//
//  HomeGridCollectionViewCell.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit
import SDWebImage

class HomeGridCollectionViewCell: BaseHomeCell {
    // MARK: - Outlet(s)
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var heartButtonView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var heartIcon: UIImageView!
    
    // MARK: - Properties
    private var isFavorite: Bool = false
    private var onTappingFavoriteIcon: ((Bool) -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        matchViewsToParent(
            heartIcon: heartIcon,
            heartButtonView: heartButtonView,
            posterImage: posterImage,
            nameLabel: movieNameLabel
        )
        super.awakeFromNib()
    }
    
    // MARK: - Setting up cell
    override func setupCell(
        with movie: Movie,
        isFavorite: Bool,
        onTappingFavoriteIcon: @escaping (Bool) -> Void
    ) {
        super.setupCell(
            with: movie,
            isFavorite: isFavorite,
            onTappingFavoriteIcon: onTappingFavoriteIcon
        )
        ratingLabel.text = String(format: "%.1f", movie.voteAverage ?? 0.0)
    }
}
