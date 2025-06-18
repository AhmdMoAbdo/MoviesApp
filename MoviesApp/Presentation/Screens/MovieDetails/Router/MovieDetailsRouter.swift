//
//  MovieDetailsRouter.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class MovieDetailsRouter {
    // MARK: - Routes
    enum Route {
        case popBack
        case movieWebsite(URL)
    }
    
    // MARK: - Properties
    private weak var viewController: UIViewController?
    
    // MARK: - Module Creation
    static func createModule(
        movieId: Int,
        isFavorite: Bool,
        favoriteStateDelegate: MovieFavoriteStateUpdable?
    ) -> UIViewController {
        let router = MovieDetailsRouter()
        let viewModel = MovieDetailsViewModel(
            movieID: movieId,
            isFavorite: isFavorite,
            router: router,
            detailsUseCase: MovieDetailsUseCase(),
            favStateDelegate: favoriteStateDelegate
        )
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
    
    // MARK: - Navigation Handling
    func navigateTo(_ route: Route) {
        switch route {
        case .popBack:
            viewController?.navigationController?.popViewController(animated: true)
            
        case let .movieWebsite(url):
            let webVC = WebViewController(url: url)
            viewController?.present(webVC, animated: true)
        }
    }
}
