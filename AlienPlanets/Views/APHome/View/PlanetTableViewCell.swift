//
//  PlanetTableViewCell.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 25/05/23.
//

import UIKit

public class PlanetTableViewCell: UITableViewCell {
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var rotationPeriodLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!


    public func configure(planet: Planets) {
        planetNameLabel.text = planet.name
        rotationPeriodLabel.text = planet.rotationPeriod
        orbitalPeriodLabel.text = planet.orbitalPeriod
        diameterLabel.text = planet.diameter
        climateLabel.text = planet.climate
        gravityLabel.text = planet.gravity
        terrainLabel.text = planet.terrain
        populationLabel.text = planet.population
          
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 2.0
    }
}
