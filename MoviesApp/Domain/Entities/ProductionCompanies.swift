//
//  ProductionCompanies.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

struct ProductionCompanies: Codable {
    var id: Int?
    var logoPath: String?
    var name: String?
    var originCountry: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }
}
