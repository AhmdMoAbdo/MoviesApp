//
//  HomeMoviesEndPoint.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import Foundation

enum HomeMoviesEndPoint: EndPoint {
    case homeMovies(page: Int)
}

extension HomeMoviesEndPoint {
    var path: String {
        switch self {
        case .homeMovies:
            return "discover/movie"
        }
    }
    
    var queryParameters: [String : String?] {
        switch self {
        case let .homeMovies(page):
            return ["page": "\(page)"]
        }
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var bodyParmaters: [String : Any?] {
        [:]
    }
}
