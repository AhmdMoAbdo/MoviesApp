//
//  UITableView+SelfSized.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

/// TableView that adds height constraint based on its content
class SelfSizedTableView: UITableView {
    lazy var heightConstrains: NSLayoutConstraint = {
        let heightConstraints = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
        heightConstraints.isActive = true
        return heightConstraints
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addConstraint(heightConstrains)
    }

    override var contentSize: CGSize {
        didSet {
            heightConstrains.constant = (contentSize.height * zoomScale)
        }
    }
}
