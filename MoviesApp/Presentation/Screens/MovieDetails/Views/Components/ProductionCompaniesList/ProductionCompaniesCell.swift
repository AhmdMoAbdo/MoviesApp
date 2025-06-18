//
//  ProductionCompaniesCell.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit
import SDWebImage

class ProductionCompaniesCell: UITableViewCell {
    // MARK: - Outlet(s)
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    
    // MARK: - Cell Setup
    func setupCell(with company: ProductionCompanies) {
        companyName.text = company.name
        companyLogo.sd_imageIndicator = SDWebImageActivityIndicator.white
        companyLogo.sd_setImage(with: ImageURLCreator.createURL(for: company.logoPath ?? ""))
    }
}
