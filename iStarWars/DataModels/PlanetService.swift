//
//  PlanetService.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 17/05/23.
//

import Foundation
import CoreData

/// PlanetService is responsible for fetching planet records from local persistence if the data has already been downloaded.
class PlanetService {
    let context: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        context = moc
    }
    
    func fetchPlanets() -> NSFetchedResultsController<Planet> {
        let sortDiscriptor = NSSortDescriptor(key: "name", ascending: true)
        let request = Planet.fetchRequest()
        request.sortDescriptors = [sortDiscriptor]
        request.fetchBatchSize = 10
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: "PlanetLibrary")
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            debugPrint("Error occured while fetching Planet data: \(error.localizedDescription)")
        }
        
        return fetchedResultsController
    }
    
    /// Read and retrieve planets from local persistence and return the array of Planet objects if available, otherwise return empty list
    /// - Parameter sortDescriptors: sortDescriptors
    /// - Returns: [Planet]
    func fetchAllPlanets(sortDescriptors: [NSSortDescriptor]) -> [Planet] {
        return fetchAllResources(sortDescriptors: sortDescriptors)
    }
    
    private func fetchAllResources<T: NSManagedObject>(sortDescriptors: [NSSortDescriptor]) -> [T] {
        let resourceName = String(describing: T.self)
        
        let request = NSFetchRequest<T>(entityName: resourceName)
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = 10
        
        do {
            let results = try context.fetch(request)
            return results
        } catch {
            debugPrint("Failed to fetch resources: \(error.localizedDescription)")
        }
        
        return [T]()
    }
    
    /// Save the array of Planet objects to local persistence
    /// - Parameter planetItems: array of codable PlanetItem objects download from server
    func saveItemsInCoreData(planetItems: [PlanetItem]) {
        _ = planetItems.map { self.createPlanetEntity(with: $0) }
        
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Failed to fetch resources: \(error.localizedDescription)")
        }
    }
    
    /// Generates a Planet model object using a codable PlanetItem object
    /// - Parameter planetItem: codable PlanetItem object
    /// - Returns: A coredata managed object - Planet
    private func createPlanetEntity(with planetItem: PlanetItem) -> NSManagedObject {
        let planet = Planet(context: context)
        planet.name = planetItem.name
        planet.diameter = planetItem.diameter
        planet.climate = planetItem.climate
        planet.terrain = planetItem.terrain
        planet.population = planetItem.population
        
        if let createdDate = DateFormatter.planetDateFormatter.date(from: planetItem.created ?? "") {
            planet.created = createdDate
        }
        
        return planet
    }
}
