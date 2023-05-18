//
//  NetworkManaging.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case badRequest
    case internalServerError
    case requestTimedOut
    case parsingError
    case noData
    case invalidAccess
}

protocol NetworkManaging {
    func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, NetworkError>) -> Void)
}
