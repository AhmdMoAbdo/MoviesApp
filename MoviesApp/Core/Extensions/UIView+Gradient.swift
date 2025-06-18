//
//  UIView+Gradient.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

// MARK: - Adding Gradient layer
extension UIView {
    func addBackgroundGradient(colors: [CGColor], direction: GradientDirection) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = direction.getStartingPoint()
        gradient.endPoint = direction.getEndingPoint()
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Direction of the gradient layer
enum GradientDirection {
    case vertical
    case horizontal
    
    func getStartingPoint() -> CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 0)
            
        case .horizontal:
            return CGPoint(x: 0, y: 0.5)
        }
    }
    
    func getEndingPoint() -> CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 1)
            
        case .horizontal:
            return CGPoint(x: 1, y: 0.5)
        }
    }
}
