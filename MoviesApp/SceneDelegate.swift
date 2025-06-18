//
//  SceneDelegate.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let splashScreen = SplashViewController()
        window?.rootViewController = splashScreen
        window?.makeKeyAndVisible()
    }
}
