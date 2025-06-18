//
//  MovieDetailsEndPoint.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

enum MovieDetailsEndPoint: EndPoint {
    case movieDetails(movieID: Int)
}

extension MovieDetailsEndPoint {
    var path: String {
        switch self {
        case .movieDetails(let movieID):
            return "movie/\(movieID)"
        }
    }
    
    var queryParameters: [String : String?] {
        [:]
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var bodyParmaters: [String : Any?] {
        [:]
    }
}
