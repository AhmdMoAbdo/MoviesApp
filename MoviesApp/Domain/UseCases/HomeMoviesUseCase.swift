//
//  HomeMoviesUseCase.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import Foundation

class HomeMoviesUseCase: APIService<HomeMoviesEndPoint> {
    // MARK: - Properties
    private var currentPage = 1
    
    // MARK: - Getting home movies
    func getHomeMovies(completion: @escaping (Result<[Movie], NetworkErrors>) -> Void) {
        sendRequest(
            to: .homeMovies(page: currentPage)
        ) { [weak self] (result: Result<BaseListResponse<Movie>, NetworkErrors>) in
            guard let self else { return }
            switch result {
            case let .success(moviesResponse):
                completion(.success(moviesResponse.results ?? []))
                currentPage += 1
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
