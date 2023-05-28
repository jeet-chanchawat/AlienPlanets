//
//  Planets.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 19/05/23.
//

import Foundation

// MARK: - Planets
public struct Planets: Codable {
    public let name: String
    public let rotationPeriod: String
    public let orbitalPeriod: String
    public let diameter: String
    public let climate: String
    public let gravity: String
    public let terrain: String
    public let surfaceWater: String
    public let population: String
    public let residents: [String]
    public let films: [String]
    public let created: String
    public let edited: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}

