//
//  FullScreenErrorView.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import UIKit

class FullScreenErrorView: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var tryAgainButtonView: UIView!
    
    // MARK: - Properties
    private var tryAgainButtonAction: (() -> Void)?
    
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
        setupTryAgainButton()
    }
    
    // MARK: - Try again button setup
    private func setupTryAgainButton() {
        tryAgainButtonView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapToTryAgain)
            )
        )
    }
    
    // MARK: - Try again action
    @objc private func didTapToTryAgain(_ gesture: UITapGestureRecognizer) {
        tryAgainButtonAction?()
    }
    
    // MARK: - Attach the view to a super view
    func attachTo(_ view: UIView, tryAgainAction: @escaping (() -> Void)) {
        self.tryAgainButtonAction = tryAgainAction
        tryAgainButtonView.addBackgroundGradient(
            colors: [UIColor.linearGradientStartColor.cgColor, UIColor.linearGradientEndColor.cgColor],
            direction: .horizontal
        )
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
