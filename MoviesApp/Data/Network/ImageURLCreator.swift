//
//  ImageURLCreator.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

class ImageURLCreator {
    static func createURL(for path: String) -> URL? {
        return URL(string: "\(Constants.imageBaseURL)\(path)")
    }
}
