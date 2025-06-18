//
//  Genres.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

struct Genres: Codable {
    var id: Int?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
