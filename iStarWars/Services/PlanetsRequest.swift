//
//  PlanetsRequest.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 16/05/23.
//

import Foundation
import CoreData

/// Declares common behaviour of every service
protocol ServiceProviding {
    func makeRequest() -> Request
    func fetch<T>(completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
}

/// Service Request to fetch Astronomy Picture of the day service
class PlanetsRequest: ServiceProviding {
    
    /// Populates request based on query parameters
    /// Also saves a formatted request into Core data
    /// - Returns: Request
    func makeRequest() -> Request {
        
        let reqUrlPath = Environment.planets
        
        let request = Request(path: reqUrlPath, method: .get, contentType: "application/json", headerParams: nil, type: .planets, body: nil)
        return request
    }
    
    /// Generic implementation of fetch service
    func fetch<T>(completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let request = makeRequest()
        NetworkManager().execute(request: request) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}
