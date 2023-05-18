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

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let dataTask = dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
        return dataTask
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
