//
//  ServiceRequestFactory.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 16/05/23.
//

import Foundation

/// Factory class that generates requests to fetch various resources
class ServiceRequestFactory {
    static func createPlanets() -> ServiceProviding {
        return PlanetsRequest()
    }
}
