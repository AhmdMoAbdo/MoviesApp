//
//  APIService.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 16/06/2025.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    associatedtype T: EndPoint
    func sendRequest<U: Codable>(to endpoint: T, completion: @escaping (Result<U, NetworkErrors>) -> Void)
}

class APIService<T: EndPoint>: APIServiceProtocol {
    func sendRequest<U: Codable>(to endpoint: T, completion: @escaping (Result<U, NetworkErrors>) -> Void) {
        guard let request = endpoint.urlRequest else {
            completion(.failure(.badRequest))
            return
        }
        AF.request(request)
            .responseDecodable(of: U.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                    
                case .failure:
                    switch response.response?.statusCode ?? 0 {
                    case 401:
                        completion(.failure(.unAuthorized))
                        
                    case 404:
                        completion(.failure(.notFound))
                        
                    default:
                        completion(.failure(.serverError))
                    }
                }
            }
    }
}
