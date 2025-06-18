//
//  SplashViewController.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet weak var sloganContainerStack: UIStackView!
    @IBOutlet weak var lottieView: LottieAnimationView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieView.play { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self else { return }
                sloganContainerStack.alpha = 1
            } completion: { [weak self] _ in
                guard let self else { return }
                presentHomeScreen()
            }
        }
    }
    
    // MARK: - Present home screen after all animations are done
    private func presentHomeScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            let navigationController = UINavigationController(rootViewController: HomeRouter.createModule())
            navigationController.navigationBar.isHidden = true
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.modalTransitionStyle = .flipHorizontal
            present(navigationController, animated: true)
        }
    }
}
