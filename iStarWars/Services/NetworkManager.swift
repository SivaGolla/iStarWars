//
//  NetworkManager.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 16/05/23.
//

import Foundation

/// Custom Errors
enum NetworkError: Error {
    case urlError
    case badRequest
    case internalServerError
    case requestTimedOut
    case parsingError
    case noData
    case invalidAccess
}

/// Handles various network requests of type Request
class NetworkManager {
        
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    /// To execute a Request object which was created earlier.
    /// - Parameters:
    ///   - request: Request
    ///   - completion: completion with Result (<T, NetworkError>) of the operation
    func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let path = request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: path) else {
            completion(.failure(.urlError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addValue(request.contentType, forHTTPHeaderField: "Content-Type")
        
        if let headerParams = request.headerParams {
            for (key, value) in headerParams {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if request.method == .post || request.method == .put, let body = request.body {
            urlRequest.httpBody = body
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badRequest))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...300:
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    debugPrint(error.localizedDescription)
                    completion(.failure(.parsingError))
                }
                
            case 401:
                completion(.failure(.invalidAccess))
            case 500...599:
                completion(.failure(.internalServerError))
            default:
                completion(.failure(.badRequest))
            }
        })
        task.resume()
    }
}
