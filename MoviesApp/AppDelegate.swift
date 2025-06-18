//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        ReachabilityManager.shared.startConnectionMonitoring()
        return true
    }
}
