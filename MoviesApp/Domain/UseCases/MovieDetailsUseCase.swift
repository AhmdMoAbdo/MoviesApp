//
//  MovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

class MovieDetailsUseCase: APIService<MovieDetailsEndPoint> {
    func getMovieDetails(movieId: Int, completion: @escaping (Result<Movie, NetworkErrors>) -> Void) {
        sendRequest(
            to: .movieDetails(movieID: movieId)
        ) { (response: Result<Movie, NetworkErrors>) in
            switch response {
            case let .success(movie):
                completion(.success(movie))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
