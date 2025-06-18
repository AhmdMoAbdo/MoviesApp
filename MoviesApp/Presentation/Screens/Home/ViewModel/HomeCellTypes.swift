//
//  HomeCellTypes.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

// MARK: - Cell types to be used in home screen
enum HomeCellTypes: String {
    case grid
    case banner
    
    // MARK: - The image to be used during each case
    func getAppropriateButtonImage() -> UIImage {
        switch self {
        case .grid:
            return UIImage(systemName: "rectangle.grid.1x2") ?? UIImage()

        case .banner:
            return UIImage(systemName: "square.grid.2x2") ?? UIImage()
        }
    }
    
    // MARK: - Relevant cell size
    func getCellSize() -> CGSize {
        switch self {
        case .grid:
            return CGSize(width: (UIScreen.main.bounds.width - 40) / 3, height: 230)
            
        case .banner:
            return CGSize(width: UIScreen.main.bounds.width - 16, height: 200)
        }
    }
}
