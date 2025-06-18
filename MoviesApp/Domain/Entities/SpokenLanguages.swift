//
//  SpokenLanguages.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

struct SpokenLanguages: Codable {
    var englishName: String?
    var iso6391: String?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name = "name"
    }
}
