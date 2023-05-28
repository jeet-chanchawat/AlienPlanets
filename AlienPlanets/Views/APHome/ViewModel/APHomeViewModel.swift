//
//  APHomeViewModel.swift
//  AlienPlanets
//  It is heart of HomeViewController, All the future business logics should be written here
//
//  Created by Jeet Chanchawat on 19/05/23.
//

import Foundation

protocol APHomeViewModelProtocol {
    func getPlanetData(completion: @escaping (Result<[Planets], Error>) -> Void)
}

class APHomeViewModel: APHomeViewModelProtocol {
    let planetsRequest: PlanetsRequest
    
    public init(planetsRequest: PlanetsRequest) {
        self.planetsRequest = planetsRequest
    }
    
    func getPlanetData(completion: @escaping (Result<[Planets], Error>) -> Void) {
        
        let planetsRequest = PlanetsRequest()
        
        RepositoryManager.shared.getDataFromRepositories(with: planetsRequest) { (result: Result<PlanetsResponse, Error>) in
            switch result {
            case .success(let planetResponse):
                completion(.success(planetResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
