//
//  Planet.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 16/05/23.
//

import Foundation
import CoreData

@objc(Planet)
class Planet: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name, diameter, climate, population, terrain, created
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "Planet", in: context) else {
            throw DecoderError.missingManagedObjectContext
        }
        
//        self.init(entity: entity, insertInto: context)
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.diameter = try container.decode(String.self, forKey: .diameter)
        self.diameter = try container.decode(String.self, forKey: .diameter)
        self.population = try container.decode(String.self, forKey: .population)
        self.terrain = try container.decode(String.self, forKey: .terrain)
        let createdDateString = try container.decode(String.self, forKey: .created)
        if let createdDate = DateFormatter.planetDateFormatter.date(from: createdDateString) {
            self.created = createdDate
        }
//        self.relation = try container.decode(Set<RelationClassName>.self, forKey: .completions) as NSSet
    }
    
}
