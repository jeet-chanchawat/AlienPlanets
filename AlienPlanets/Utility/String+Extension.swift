//
//  String+Extension.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 23/05/23.
//

import Foundation
import CryptoKit

extension String {
    // this method is being used to generate a unique file name for each URL
    func getSHA256Hash() -> String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }
}
