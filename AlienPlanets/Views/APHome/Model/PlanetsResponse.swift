//
//  Planets.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 19/05/23.
//

import Foundation

// MARK: - PlanetsResponse
public struct PlanetsResponse: Codable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [Planets]

    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
