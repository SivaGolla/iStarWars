//
//  Environment.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 15/05/23.
//

import Foundation

/// Supported Application Environments
enum Environment {
    case dev, uat, prod
}

extension Environment {
    
    /// Points to current environment based on running target
    static var current: Environment {
        let targetName = Bundle.main.infoDictionary?["TargetName"] as? String

        switch targetName {
        case "iStarWars-Prod":
            return Environment.prod
        case "iStarWars-Uat":
            return Environment.uat
        default:
            return Environment.dev
        }
    }
    
    /// end point base url
    var baseUrlPath: String {
        switch self {
        case .prod:
            return "https://swapi.dev/api/"
        case .uat:
            return "https://swapi.dev/api/"
        case .dev:
            return "https://swapi.dev/api/"
        }
    }
}


// MARK: All Service Endpoints
extension Environment {
    
    /// End points of available resources within the service
    static let planets = Environment.current.baseUrlPath + "planets/"
    static let people = Environment.current.baseUrlPath + "people/"
    static let starships = Environment.current.baseUrlPath + "starships/"
    static let vehicles = Environment.current.baseUrlPath + "vehicles/"
    static let species = Environment.current.baseUrlPath + "species/"
    static let films = Environment.current.baseUrlPath + "films/"
    
    
}
