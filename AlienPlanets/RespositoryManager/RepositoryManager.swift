//
//  RepositoryManager.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 23/05/23.
//

import Foundation

public class RepositoryManager {
    
    static let shared = RepositoryManager()
    
    var jsonFileManager: JsonFileManagerProtocol!
    var apiCaller: ApiCallerProtocol!
    
    private init() {
        initiailise()
    }
    
    // to be called for unit testing only
    func initiailise(fileManager: JsonFileManagerProtocol = JsonFileManager(),
                       apiCaller: ApiCallerProtocol =  ApiCaller()) {
        self.jsonFileManager = fileManager
        self.apiCaller = apiCaller
    }
    
    
    func getDataFromRepositories<T: Codable>(with request: RequestProtocol, allowNetwork: Bool = true, completion: @escaping (Result<T, Error>) -> Void) {
        if let cachedData: T = jsonFileManager.loadJsonData(forUrl: request.path) {
            completion(.success(cachedData))
        } else {
            if !allowNetwork {
                completion(.failure(NetworkError.cacheError))
            }
            apiCaller.makeRequest(with: request) {[weak self] (result: Result<T, Error>) in
                switch result {
                case .success(let data):
                    self?.jsonFileManager.saveJsonData(forUrl: request.path, with: data)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
