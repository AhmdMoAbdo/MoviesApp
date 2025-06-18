//
//  BaseListResponse.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

struct BaseListResponse<T: Codable>: Codable {
    var page: Int?
    var results: [T]?
    var totalPages: Int?
    var totalResults: Int?

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
