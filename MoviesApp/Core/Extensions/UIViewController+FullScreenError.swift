//
//  UIViewController+FullScreenError.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import UIKit

/// Center screen error in one line from any VC with a try again action
extension UIViewController {
    func addFullScreenErrorView(tryAgainAction: (() -> Void)?) {
        removeFullScreenErrorView()
        let fullScreenErrorView = FullScreenErrorView()
        fullScreenErrorView.attachTo(view) {
            tryAgainAction?()
        }
    }
    
    func removeFullScreenErrorView() {
        view.subviews.first(where: { $0 is FullScreenErrorView })?.removeFromSuperview()
    }
}
