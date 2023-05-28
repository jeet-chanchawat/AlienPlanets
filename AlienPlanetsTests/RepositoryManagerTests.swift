//
//  RepositoryManagerTests.swift
//  AlienPlanetsTests
//
//  Created by Jeet Chanchawat on 28/05/23.
//

import XCTest
@testable import AlienPlanets

class RepositoryManagerTests: XCTestCase {
    
    var repositoryManager: RepositoryManager!
    
    override func setUp() {
        super.setUp()
        repositoryManager = RepositoryManager.shared
        repositoryManager.initiailise(
            fileManager: MockJsonFileManager(),
            apiCaller: MockApiCaller()
        )
    }
    
    override func tearDown() {
        repositoryManager = nil
        super.tearDown()
    }
    
    func testGetDataFromRepositories_LoadsFromCache() {
        let request = MockRequest(path: "mock-url")
        
        let expectation = XCTestExpectation(description: "Load data from cache")
        
        repositoryManager.getDataFromRepositories(with: request) { (result: Result<MockData, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.name, "Cached Data")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error should not occur: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetDataFromRepositories_MakesNetworkRequest() {
        let request = MockRequest(path: "mock-url-network-success")
        
        let expectation = XCTestExpectation(description: "Make network request")
        repositoryManager.jsonFileManager = MockJsonFileManager()
        repositoryManager.apiCaller = MockApiCaller()
        repositoryManager.getDataFromRepositories(with: request) { (result: Result<MockData, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.name, "Network Data")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error should not occur: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetDataFromRepositories_CacheError() {
        let request = MockRequest(path: "mock-url-cache-error")
        
        let expectation = XCTestExpectation(description: NetworkError.cacheError.rawValue)
        
        RepositoryManager.shared.jsonFileManager = MockJsonFileManager()
        
        RepositoryManager.shared.getDataFromRepositories(with: request, allowNetwork: false) { (result: Result<MockData, Error>) in
            switch result {
            case .success(_):
                XCTFail("Data should not be loaded")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.cacheError.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
        
    func testGetDataFromRepositories_NetworkRequestError() {
        let request = MockRequest(path: "mock-url-network-error")
        
        let expectation = XCTestExpectation(description: NetworkError.networkError.rawValue)
        repositoryManager.apiCaller = MockApiCaller()
        repositoryManager.jsonFileManager = MockJsonFileManager()
        repositoryManager.getDataFromRepositories(with: request) { (result: Result<MockData, Error>) in
            switch result {
            case .success(_):
                XCTFail("Data should not be loaded")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.networkError.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock classes for testing

struct MockData: Codable {
    let name: String
}

struct MockRequest: RequestProtocol {
    let path: String
}

class MockJsonFileManager: JsonFileManagerProtocol {

    func saveJsonData<T>(forUrl: String, with data: T) -> Bool where T : Encodable {
        // Simulate saving data to cache
        if forUrl == "mock-url-network-success" {
            return false
        }
        if let mockData = data as? MockData {
            if mockData.name == "Cached Data" {
                return true
            }
        }
        return false
    }

    func loadJsonData<T>(forUrl: String) -> T? where T : Decodable {
        if forUrl == "mock-url-cache-error" {
            return nil
        } else if forUrl == "mock-url-network-success" {
            return nil
        } else if forUrl == "mock-url-network-error" {
            return nil
        }

        // Simulate loading data from cache
        if T.self == MockData.self {
            let mockData = MockData(name: "Cached Data")
            return mockData as? T
        }
        
        return nil
    }
}

class MockApiCaller: ApiCallerProtocol {
    func makeRequest<T>(with request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        // Simulate making network request
        if let mockRequest = request as? MockRequest {
            if mockRequest.path == "mock-url-network-success" {
                let mockData = MockData(name: "Network Data")
                completion(.success(mockData as! T))
            } else if mockRequest.path == "mock-url-network-error" {
                
                completion(.failure(NetworkError.networkError))
            }
        }
    }
}
