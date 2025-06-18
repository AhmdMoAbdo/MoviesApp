//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

class HomeViewModel {
    // MARK: - Properties
    let router: HomeRouter
    let homeMoviesUseCase: HomeMoviesUseCase
    let favoriteMoviesUseCase: FavoriteMoviesUseCase
    var homeMovies = [Movie]()
    var favoriteMovies: [Int] = []
    
    // MARK: - Observable(s)
    var didUpdateHomeMovies = Observable<Void>()
    var loadingObservable = Observable<Bool>()
    var errorObservable = Observable<NetworkErrors>()
    var favoriteStateObservable = Observable<(Int, Bool)>()
    
    // MARK: - Initializer(s)
    init(
        router: HomeRouter,
        homeMoviesUseCase: HomeMoviesUseCase,
        favoriteMoviesUseCase: FavoriteMoviesUseCase
    ) {
        self.router = router
        self.homeMoviesUseCase = homeMoviesUseCase
        self.favoriteMoviesUseCase = favoriteMoviesUseCase
        favoriteMovies = favoriteMoviesUseCase.getFavoriteMovies()
    }
    
    // MARK: - Loading Home Movies
    func getHomeMovies() {
        loadingObservable.onNext(true)
        homeMoviesUseCase.getHomeMovies { [weak self] result in
            guard let self = self else { return }
            loadingObservable.onNext(false)
            switch result {
            case let .success(movies):
                homeMovies += movies
                didUpdateHomeMovies.onNext(())
                
            case let .failure(error):
                errorObservable.onNext(error)
            }
        }
    }
    
    // MARK: - Check whether the item is already added to favorite list
    func isFavorite(index: Int) -> Bool {
        guard let movieID = homeMovies[index].id else { return false }
        return favoriteMovies.contains(movieID)
    }
    
    // MARK: - Tapping heart icon in movies cells
    func heartButtonTapped(index: Int, isFavorite: Bool) {
        guard let movieID = homeMovies[index].id else { return }
        if isFavorite {
            favoriteMovies.append(movieID)
        } else {
            favoriteMovies.removeAll { $0 == movieID }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else { return }
            favoriteMoviesUseCase.saveMoviesList(favoriteMovies)
        }
    }
    
    // MARK: - Navigate to movie details
    func navigateToMovieDetails(index: Int) {
        guard let movieID = homeMovies[index].id else { return }
        router.navigateTo(
            .details(
                movieID: movieID,
                isFavorite: favoriteMovies.contains(movieID),
                favStateDelegate: self
            )
        )
    }
}

// MARK: - Updating favorite state from inside the details screen
extension HomeViewModel: MovieFavoriteStateUpdable {
    func updateFavoriteState(for movieID: Int, isFavorite: Bool) {
        if isFavorite {
            favoriteMovies.append(movieID)
        } else {
            favoriteMovies.removeAll { $0 == movieID }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else { return }
            favoriteMoviesUseCase.saveMoviesList(favoriteMovies)
        }
        if let itemIndex = homeMovies.firstIndex(where: { $0.id == movieID }) {
            favoriteStateObservable.onNext((itemIndex, isFavorite))
        }
    }
}

protocol MovieFavoriteStateUpdable: AnyObject {
    func updateFavoriteState(for movieID: Int, isFavorite: Bool)
}
