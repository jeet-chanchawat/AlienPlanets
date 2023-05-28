//
//  ApiCaller.swift
//  AlienPlanets
//  This class is expected to be only called by RepositoryManager to get data using API
//
//  Created by Jeet Chanchawat on 19/05/23.
//

import Foundation
protocol ApiCallerProtocol {
    func makeRequest<T: Codable>(with request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void)
}

class ApiCaller: ApiCallerProtocol {
    let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func makeRequest<T: Codable>(with request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: request.path) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        networkManager.requestData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
