//
//  HomeRouter.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class HomeRouter {
    // MARK: - Routes
    enum homeRoutes {
        case details(
            movieID: Int,
            isFavorite: Bool,
            favStateDelegate: MovieFavoriteStateUpdable
        )
    }
    
    // MARK: - Properties
    private weak var viewController: UIViewController?
    
    // MARK: - Module Creation
    static func createModule() -> HomeViewController {
        let router = HomeRouter()
        let viewModel = HomeViewModel(
            router: router,
            homeMoviesUseCase: HomeMoviesUseCase(),
            favoriteMoviesUseCase: FavoriteMoviesUseCase()
        )
        let viewController = HomeViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
    
    // MARK: - Navigation Handling
    func navigateTo(_ route: homeRoutes) {
        switch route {
        case let .details(movieID, isFav, delegate):
            navigateToMovieDetails(movieID: movieID, isFavorite: isFav, favStateDelegate: delegate)
        }
    }
    
    // MARK: - Navigation to details
    private func navigateToMovieDetails(
        movieID: Int,
        isFavorite: Bool,
        favStateDelegate: MovieFavoriteStateUpdable?
    ) {
        let detailsVC = MovieDetailsRouter.createModule(
            movieId: movieID,
            isFavorite: isFavorite,
            favoriteStateDelegate: favStateDelegate
        )
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
