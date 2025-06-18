//
//  CenterSectionMovieDetails.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class CenterSectionMovieDetails: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var containerStack: UIStackView!
    
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
    
    // MARK: - Setting up section from cell data array
    func setupSection(cellsData: [CenterSectionCellData]) {
        cellsData.forEach { cellData in
            let cellView = CenterSectionDetailsCell()
            containerStack.addArrangedSubview(cellView)
            cellView.setupCell(using: cellData)
        }
    }
}
