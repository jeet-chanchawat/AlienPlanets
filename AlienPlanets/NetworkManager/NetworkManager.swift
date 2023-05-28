//
//  NetworkManager.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 19/05/23.
//

import Foundation

enum NetworkError: String, Error{
    case noData
    case invalidUrl
    case cacheError
    case networkError
}

protocol NetworkManagerProtocol {
    func requestData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func requestData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
