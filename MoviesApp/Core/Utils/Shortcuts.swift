//
//  Shortcuts.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import UIKit

enum Shortcuts {
    static var window: UIWindow? {
        (UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) as? UIWindow
    }
}
