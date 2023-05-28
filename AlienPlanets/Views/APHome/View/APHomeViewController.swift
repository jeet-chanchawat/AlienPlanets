//
//  ViewController.swift
//  AlienPlanets
//
//  Created by Jeet Chanchawat on 19/05/23.
//

import UIKit

class APHomeViewController: UIViewController {
    private class Constants {
        static var cellName = "PlanetTableViewCell"
    }
    @IBOutlet weak var planetsTableView: UITableView!
    private var homeViewModel: APHomeViewModelProtocol = APHomeViewModel(planetsRequest: PlanetsRequest())
    private var planets: [Planets] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source for the table view
        planetsTableView.dataSource = self
        planetsTableView.delegate = self
        
        loadData()
    }
    
    func loadData() {
        
        homeViewModel.getPlanetData { result in
            switch result {
            case .success(let planets):
                print(planets)
                self.planets = planets
                DispatchQueue.main.async {
                    self.planetsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension APHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as! PlanetTableViewCell
        
        // Get the corresponding planet object for the current row
        let planet = planets[indexPath.row]
        
        // Configure the cell's text label with the planet name
        cell.configure(planet: planet)
        
        return cell
    }
    
}
