//
//  NetworkManager.swift
//  iStarWarsMock
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import Foundation
import CoreData

/// Handles various network requests of type Request
class NetworkManager: NetworkManaging {
    /// To execute a Request object which was created earlier.
    /// - Parameters:
    ///   - request: Request
    ///   - completion: completion with Result (<T, NetworkError>) of the operation
    func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        
        
        guard let path = request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: path) else {
            completion(.failure(.urlError))
            return
        }
        
        guard let mockResponseFileUrl = Bundle(for: NetworkManager.self).url(forResource: "Planets", withExtension: "json"),
              let data = try? Data(contentsOf: mockResponseFileUrl) else {
                  return completion(.failure(.badRequest))
              }
        
        let decoder = JSONDecoder()
        
        let concurrencyType = NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType
        let privateContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        privateContext.parent = CoreDataStack.shared.persistentContainer.viewContext
        
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = privateContext
        
        privateContext.performAndWait {
            do {
                let result = try decoder.decode(T.self, from: data)
                try privateContext.save()
                completion(.success(result))
            } catch {
                debugPrint(error.localizedDescription)
                completion(.failure(.parsingError))
            }
        }
    }
}
