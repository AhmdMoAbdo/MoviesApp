//
//  CommonHeadersProtocol.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import Foundation

public protocol CommonHeadersProtocol {
    var commonHeaders: [String: String] { get }
}

public extension CommonHeadersProtocol {
    var commonHeaders: [String: String] {
        var params = [String: String]()
        params["Content-Type"] = "application/json"
        params["Accept"] = "application/json"
        params["Authorization"] = "Bearer \(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "")"
        return params
    }
}
