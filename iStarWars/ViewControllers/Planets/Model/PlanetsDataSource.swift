//
//  PlanetsDataSource.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import Foundation

protocol ResourceDataSourcing {
    
}

class PlanetsDataSource {
    
    private(set) var planets: [Planet] = []
    lazy var planetService: PlanetService = {
        return PlanetService(moc: CoreDataStack.shared.persistentContainer.viewContext)
    }()
    
    func fetchPlanets() {
        let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        planets = planetService.fetchAllPlanets(sortDescriptors: sortDescriptors)
    }
    
    func loadRemotePlanets(completion: @escaping (Bool) -> Void) {
        
        let serviceRequest = ServiceRequestFactory.createPlanets()
        serviceRequest.fetch { [weak self] (result: Result<PlanetsResponseModel, NetworkError>) in
        
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(false)

                case .success(let response):
                    self?.planetService.saveItemsInCoreData(planetItems: response.results)
                    completion(true)
                }
            }
        }
    }
}
