//
//  FileManager.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 23/05/23.
//

import Foundation

public class JsonFileManager {
    
    @discardableResult
    public func saveJsonData<T: Encodable>(forUrl: String, with data: T) -> Bool {
        var isSavedSuccessfully = true
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            
            guard let cacheDirectory = JsonFileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                return false
            }
            
            let cacheFileURL = cacheDirectory.appendingPathComponent(forUrl.getSHA256Hash())
            try jsonData.write(to: cacheFileURL)
        } catch {
            print("Error saving planet cache: \(error)")
        }
        
        return true
    }
    
    public func getJsonData(forURl: String) -> String {
        
        return ""
    }
    
    public func doesFileExists(forUrl: String) -> Bool {
        return false
    }
}
