//
//  NetworkErrors.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import Foundation

enum NetworkErrors: Error {
    case badRequest
    case corruptedData
    case unAuthorized
    case notFound
    case parsingError
    case serverError
}
