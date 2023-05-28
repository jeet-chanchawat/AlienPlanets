//
//  JsonFileManagerTests.swift
//  AlienPlanetsTests
//
//  Created by Jeet Chanchawat on 27/05/23.
//

import XCTest
@testable import AlienPlanets

final class JsonFileManagerTests: XCTestCase {

        var jsonFileManager: JsonFileManager!

        override func setUp() {
            super.setUp()
            jsonFileManager = JsonFileManager()
        }

        override func tearDown() {
            jsonFileManager = nil
            super.tearDown()
        }

        func testSaveJsonData() {
            let testData = TestData(name: "Test", value: 10)

            let result = jsonFileManager.saveJsonData(forUrl: "test", with: testData)

            XCTAssertTrue(result, "Saving JSON data should succeed")
        }

        func testLoadJsonData() {
            let testData = TestData(name: "Test", value: 10)
            jsonFileManager.saveJsonData(forUrl: "test", with: testData)

            let loadedData: TestData? = jsonFileManager.loadJsonData(forUrl: "test")

            XCTAssertNotNil(loadedData, "JSON data found nil")
            XCTAssertEqual(loadedData?.name, "Test", "JSON data should have the correct name")
            XCTAssertEqual(loadedData?.value, 10, "JSON data should have correct value")
        }

        // Ttest data structure
        struct TestData: Codable {
            let name: String
            let value: Int
        }
}
