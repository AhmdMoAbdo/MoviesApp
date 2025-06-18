//
//  DetailsHeaderSection.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

struct DetailsHeaderSectionModel {
    var title: String
    var genres: String
    var watchURL: String?
    var rating: Double
    var voteCount: Int
}

class DetailsHeaderSection: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var watchTrailerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    // MARK: - Properties
    private var watchTrailerAction: (() -> Void)?
    private var viewData: DetailsHeaderSectionModel?
    
    // MARK: - Initializer(s)
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadNibFromFile()
        setupWatchTrailerView()
    }
    
    // MARK: - Watch trailier view setup
    private func setupWatchTrailerView() {
        addTapGestureRecognizer()
    }
    
    /// Tap recognizer
    private func addTapGestureRecognizer() {
        watchTrailerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToWatchTrailer)))
    }
    
    @objc private func didTapToWatchTrailer(_ gesture: UITapGestureRecognizer) {
        watchTrailerAction?()
    }
    
    // MARK: - Setting up view
    func setupView(
        using data: DetailsHeaderSectionModel,
        watchTrailerAction: @escaping () -> Void
    ) {
        watchTrailerView.addBackgroundGradient(
            colors: [UIColor.linearGradientStartColor.cgColor, UIColor.linearGradientEndColor.cgColor],
            direction: .horizontal
        )
        self.viewData = data
        self.watchTrailerAction = watchTrailerAction
        titleLabel.text = data.title
        genresLabel.text = data.genres
        watchTrailerView.isHidden = data.watchURL == nil || (data.watchURL?.isEmpty ?? false)
        ratingLabel.attributedText = getRatingAttributedText(data.rating)
        voteCountLabel.text = "\(data.voteCount) Votes"
    }
    
    // MARK: - Getting rating attributed string
    private func getRatingAttributedText(_ rating: Double) -> NSAttributedString {
        let ratingAttributedText = NSMutableAttributedString()
        ratingAttributedText.append(getBoldAttributedText(text: "\(String(format: "%.1f", rating))"))
        ratingAttributedText.append(getNormalAttributedText(text: "/10"))
        return ratingAttributedText
    }
    
    private func getNormalAttributedText(text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular)])
    }
    
    private func getBoldAttributedText(text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
    }
}
