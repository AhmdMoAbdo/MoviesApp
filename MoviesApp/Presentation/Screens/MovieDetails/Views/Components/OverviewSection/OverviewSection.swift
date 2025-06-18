//
//  OverviewSection.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class OverviewSection: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var overviewLabel: UILabel!
    
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
    
    // MARK: - Setting up overview
    func setupOverview(_ overview: String) {
        overviewLabel.text = overview
    }
}
