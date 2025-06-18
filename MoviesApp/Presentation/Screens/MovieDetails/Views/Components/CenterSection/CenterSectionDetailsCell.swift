//
//  CenterSectionDetailsCell.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

struct CenterSectionCellData {
    var headerText: String
    var detailsText: String
    var alignment: UIStackView.Alignment
}

class CenterSectionDetailsCell: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
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
    
    // MARK: - Cell setup
    func setupCell(using cellData: CenterSectionCellData) {
        headerLabel.text = cellData.headerText
        detailsLabel.text = cellData.detailsText
        containerStack.alignment = cellData.alignment
    }
}
