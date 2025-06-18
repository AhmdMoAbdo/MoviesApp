//
//  ReachabilityManager.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import Foundation
import Reachability

class ReachabilityManager {
    // MARK: - Properties
    static var shared = ReachabilityManager()
    private var bannerView = ErrorBannerView()
    private var reachability: Reachability?
    var isConnected: Bool = true
    
    // MARK: - Initializer(s)
    private init() {}
    
    // MARK: - Starting connection monitoring
    func startConnectionMonitoring() {
        let reachability = try? Reachability()
        self.reachability = reachability
        reachability?.whenReachable = { [weak self] connection in
            guard let self else { return }
            isConnected = true
            bannerView.animateViewDisappearance()
        }
        reachability?.whenUnreachable = { [weak self] _ in
            guard let self else { return }
            isConnected = false
            bannerView.attachToWindow()
        }
        try? reachability?.startNotifier()
    }
    
    // MARK: - Deinitializer(s)
    deinit {
        reachability?.stopNotifier()
    }
}
