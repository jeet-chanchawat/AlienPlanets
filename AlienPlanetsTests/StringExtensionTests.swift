//
//  StringExtensionTests.swift
//  AlienPlanetsTests
//
//  Created by Jeet Chanchawat on 27/05/23.
//

import XCTest
import CryptoKit
@testable import AlienPlanets

class StringExtensionTests: XCTestCase {

    func testGetSHA256Hash() {
        let input = "Hello, World!"
        
        let hashString = input.getSHA256Hash()
        
        XCTAssertEqual(hashString, "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f")
    }

}
