//
//  PlanetsResponseModel.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 16/05/23.
//

import Foundation

struct PlanetsResponseModel: Decodable {
    
    let count: Int
    let next: String?
    let previous: String?
    
    let results: [Planet]
}
