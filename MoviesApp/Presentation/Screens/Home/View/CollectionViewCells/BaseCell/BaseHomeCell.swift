//
//  BaseHomeCell.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import UIKit
import SDWebImage

class BaseHomeCell: UICollectionViewCell, HomeCellConfigurable {
    // MARK: - Matched outlet(s)
    weak var parentHeartIcon: UIImageView?
    weak var parentHeartButtonView: UIView?
    weak var parentPosterImage: UIImageView?
    weak var nameLabel: UILabel?
    
    // MARK: - Properties
    private var isFavorite: Bool = false
    private var onTappingFavoriteIcon: ((Bool) -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        parentHeartButtonView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeartIcon(_:))))
    }
    
    // MARK: - Favorite Icon Action
    @objc private func didTapHeartIcon(_ gesture: UITapGestureRecognizer) {
        isFavorite.toggle()
        updateHeartIcon(isFavorite: isFavorite)
        onTappingFavoriteIcon?(isFavorite)
    }
    
    // MARK: - Allowing child to match views in parent to allow for joined setup for common views in parent
    func matchViewsToParent(
        heartIcon: UIImageView,
        heartButtonView: UIView,
        posterImage: UIImageView,
        nameLabel: UILabel
    ) {
        parentHeartIcon = heartIcon
        parentHeartButtonView = heartButtonView
        parentPosterImage = posterImage
        self.nameLabel = nameLabel
    }
    
    // MARK: - Setting up cell
    func setupCell(with movie: Movie, isFavorite: Bool, onTappingFavoriteIcon: @escaping (Bool) -> Void) {
        self.isFavorite = isFavorite
        self.onTappingFavoriteIcon = onTappingFavoriteIcon
        parentPosterImage?.sd_imageIndicator = SDWebImageActivityIndicator.white
        parentPosterImage?.sd_setImage(
            with: ImageURLCreator.createURL(for: movie.posterPath ?? "")
        )
        nameLabel?.text = movie.title
        updateHeartIcon(isFavorite: isFavorite)
    }
    
    // MARK: - Updating heart icon
    private func updateHeartIcon(isFavorite: Bool) {
        parentHeartIcon?.tintColor = isFavorite ? .red : .black
    }
    
    // MARK: - Updating fav state from outside the cell
    func updateFavoriteState(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        updateHeartIcon(isFavorite: isFavorite)
    }
}
