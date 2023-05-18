//
//  MockCoreDataStackTests.swift
//  iStarWarsTests
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import XCTest
import CoreData
@testable import iStarWarsMock

class MockCoreDataStackTests: XCTestCase {

    var manager: MockCoreDataStack!
    var service: PlanetService!
    
    override func setUpWithError() throws {
        manager = MockCoreDataStack()
        service = PlanetService(moc: manager.mockContainer.viewContext)
    }

    override func tearDownWithError() throws {
        manager.clearAllPlanetsInDatabase()
        try super.tearDownWithError()
    }

    private func addPlanet() {
        let planet = Planet(context: manager.mockContainer.viewContext)
        planet.name = "Test"
    }
    
    func testSaveContext() {
        addPlanet()
        
        XCTAssertNoThrow(manager.saveContext())
    }
    
    func testFetchAllPlanet() {
        var savedPlanets = service.fetchAllPlanets(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])

        XCTAssertEqual(savedPlanets, [])
        
        addPlanet()
        do {
            try manager.mockContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error.localizedDescription)")
        }
        
        savedPlanets = service.fetchAllPlanets(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        
        XCTAssertEqual(savedPlanets.count, 1)
        
        let savedPlanet = savedPlanets[0]
        if let name = savedPlanet.name {
            XCTAssertEqual(name, "Test")
        }
    }

    func testSavePlanetSmall() {
        let planetJson = """
        {
            "name": "Tatooine",
            "rotation_period": "23",
            "orbital_period": "304",
            "diameter": "10465",
            "climate": "arid",
            "gravity": "1 standard",
            "terrain": "desert",
            "surface_water": "1",
            "population": "200000",
            "residents": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/2/",
                "https://swapi.dev/api/people/4/",
                "https://swapi.dev/api/people/6/",
                "https://swapi.dev/api/people/7/",
                "https://swapi.dev/api/people/8/",
                "https://swapi.dev/api/people/9/",
                "https://swapi.dev/api/people/11/",
                "https://swapi.dev/api/people/43/",
                "https://swapi.dev/api/people/62/"
            ],
            "films": [
                "https://swapi.dev/api/films/1/",
                "https://swapi.dev/api/films/3/",
                "https://swapi.dev/api/films/4/",
                "https://swapi.dev/api/films/5/",
                "https://swapi.dev/api/films/6/"
            ],
            "created": "2014-12-09T13:50:49.641000Z",
            "edited": "2014-12-20T20:58:18.411000Z",
            "url": "https://swapi.dev/api/planets/1/"
        }
        """

        let data = Data(planetJson.utf8)
        do {
            let results = try JSONDecoder().decode(PlanetItem.self, from: data)
            service.saveItemsInCoreData(planetItems: [results])
        } catch {
            debugPrint(error.localizedDescription)
        }

        let planets = service.fetchAllPlanets(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        XCTAssertEqual(planets.count, 1)
        let savedPlanet = planets[0]

        XCTAssertEqual(savedPlanet.name, "Tatooine")
        XCTAssertEqual(savedPlanet.population, "200000")
        XCTAssertEqual(savedPlanet.diameter, "10465")
        XCTAssertEqual(savedPlanet.climate, "arid")
        XCTAssertEqual(savedPlanet.terrain, "desert")

        let createdDate = DateFormatter.planetDateFormatter.date(from: "2014-12-09T13:50:49.641000Z")!
        XCTAssertEqual(savedPlanet.created, createdDate)
    }
}
