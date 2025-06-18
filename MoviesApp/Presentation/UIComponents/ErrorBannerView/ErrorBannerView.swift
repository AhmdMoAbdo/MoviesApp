//
//  ErrorBannerView.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import UIKit

class ErrorBannerView: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Properties
    var topConstraint: NSLayoutConstraint?
    
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
    }
    
    // MARK: - Attaching view to window
    func attachToWindow() {
        guard let window = Shortcuts.window else { return }
        translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(self)
        topConstraint = topAnchor.constraint(equalTo: window.topAnchor, constant: -200)
        guard let topConstraint else { return }
        NSLayoutConstraint.activate([
            topConstraint,
            leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0),
            trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: 0)
        ])
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            animateViewAppearance()
        }
    }
    
    // MARK: - Animating View Appearance
    private func animateViewAppearance() {
        topConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            superview?.layoutIfNeeded()
        }
    }
    
    // MARK: - Animating view dismissal
    func animateViewDisappearance() {
        topConstraint?.constant = -200
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else { return }
            superview?.layoutIfNeeded()
        }) { [weak self] _ in
            guard let self else { return }
            self.removeFromSuperview()
        }
    }
}
