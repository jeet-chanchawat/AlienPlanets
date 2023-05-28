//
//  JsonFileManager.swift
//  AlienPlanets
//  This class is expected to be only called by RepositoryManager to get data from cache
//
//  Created by Jeet Chanchawat on 23/05/23.
//

import Foundation

public protocol JsonFileManagerProtocol {
    @discardableResult
    func saveJsonData<T: Encodable>(forUrl: String, with data: T) -> Bool
    func loadJsonData<T: Decodable>(forUrl: String) -> T?
}

public class JsonFileManager: JsonFileManagerProtocol {
    @discardableResult
    public func saveJsonData<T: Encodable>(forUrl: String, with data: T) -> Bool {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            
            guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                return false
            }
            
            let cacheFileURL = cacheDirectory.appendingPathComponent(forUrl.getSHA256Hash())
            try jsonData.write(to: cacheFileURL)
            return true
        } catch {
            print("Error saving planet cache: \(error)")
            return false
        }
    }
    
    public func loadJsonData<T: Decodable>(forUrl: String) -> T? {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let cacheFileURL = cacheDirectory.appendingPathComponent(forUrl.getSHA256Hash())
        
        guard FileManager.default.fileExists(atPath: cacheFileURL.path) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: cacheFileURL)
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: jsonData)
            return data
        } catch {
            print("Error loading cache: \(error)")
            return nil
        }
    }
}

