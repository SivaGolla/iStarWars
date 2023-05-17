//
//  ServiceRequestFactory.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 16/05/23.
//

import Foundation

class ServiceRequestFactory {
    static func createPlanets() -> ServiceProviding {
        return PlanetsRequest()
    }
}
