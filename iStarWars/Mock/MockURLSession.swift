//
//  MockURLSession.swift
//  iStarWarsTests
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import Foundation

class MockURLSession: URLSessionProtocol {

    var mockDataTask = MockURLSessionDataTask()
    var mockData: Data?
    var mockError: Error?
    
    private (set) var lastURL: URL?
    
    func mockHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        if let urlPath = request.url?.absoluteString, urlPath == Environment.planets {
            guard let mockResponseFileUrl = Bundle(for: NetworkManager.self).url(forResource: "Planets", withExtension: "json"),
                  let data = try? Data(contentsOf: mockResponseFileUrl) else {
                      completionHandler(nil, nil, mockError)
                      return mockDataTask
                  }
            mockData = data
        }
        
        completionHandler(mockData, mockHttpURLResponse(request: request), mockError)
        return mockDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
