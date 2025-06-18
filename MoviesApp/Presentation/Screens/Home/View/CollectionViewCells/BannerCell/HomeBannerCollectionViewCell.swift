//
//  HomeBannerCollectionViewCell.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class HomeBannerCollectionViewCell: BaseHomeCell {
    // MARK: - Outlet(s)
    @IBOutlet weak var heartIcon: UIImageView!
    @IBOutlet weak var heartButtonView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    // MARK: - Properties
    private var isFavorite: Bool = false
    private var onTappingFavoriteIcon: ((Bool) -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        matchViewsToParent(
            heartIcon: heartIcon,
            heartButtonView: heartButtonView,
            posterImage: posterImage,
            nameLabel: title
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
        overView.text = movie.overview
        releaseDateLabel.text = getFormattedReleaseDate(movie: movie)
        ratingLabel.attributedText = getRatingAttributedText(movie.voteAverage ?? 0.0)
        voteCountLabel.attributedText = getVoteCountAttributedText(movie.voteCount ?? 0)
    }
    
    // MARK: - Getting the formatted release date if available
    func getFormattedReleaseDate(movie: Movie?) -> String {
        guard let releaseDate = movie?.releaseDate else {
            return ""
        }
        let releaseDateArray = releaseDate.split(separator: "-")
        let day = releaseDateArray.last ?? ""
        let year = releaseDateArray.first ?? ""
        let month = Int(releaseDateArray[safe: 1] ?? "1") ?? 1
        let monthName = DateFormatter().shortMonthSymbols[month - 1]
        return "\(day) \(monthName) \(year)"
    }
    
    // MARK: - Getting rating attributed string
    private func getRatingAttributedText(_ rating: Double) -> NSAttributedString {
        let ratingAttributedText = NSMutableAttributedString()
        ratingAttributedText.append(getBoldAttributedText(text: "\(String(format: "%.1f", rating))"))
        ratingAttributedText.append(getNormalAttributedText(text: "/10"))
        return ratingAttributedText
    }
    
    // MARK: - Vote count attributed string
    private func getVoteCountAttributedText(_ voteCount: Int) -> NSAttributedString {
        let ratingAttributedText = NSMutableAttributedString()
        ratingAttributedText.append(getBoldAttributedText(text: "\(voteCount)"))
        ratingAttributedText.append(getNormalAttributedText(text: " Votes"))
        return ratingAttributedText
    }
    
    /// Normal Attributed Text
    private func getNormalAttributedText(text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular)])
    }
    
    /// Bold Attributed Text
    private func getBoldAttributedText(text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
    }
}
