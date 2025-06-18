//
//  ProductionCountries.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

struct ProductionCountries: Codable {
    var iso31661: String?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "name"
    }
}
