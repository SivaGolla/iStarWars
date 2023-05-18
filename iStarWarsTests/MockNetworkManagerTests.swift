//
//  MockNetworkManagerTests.swift
//  iStarWarsTests
//
//  Created by Venkata Sivannarayana Golla on 18/05/23.
//

import XCTest
@testable import iStarWarsMock

class MockNetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var session: MockURLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        session = MockURLSession()
        networkManager = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExecuteRequestForURL() {
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        let request = Request(path: "https://mockurl", method: .get, contentType: "application/json", headerParams: nil, type: .planets, body: nil)
        
        networkManager.execute(request: request, completion: { [weak self](result: (Result<PlanetsResponseModel, NetworkError>)) in
            if let sessionUrl = self?.session.lastURL {
                XCTAssert(sessionUrl == url)
            }
        })
        
    }
        
    func testExecuteDataTaskWithResumeCalled() {
        
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        let request = Request(path: "https://mockurl", method: .get, contentType: "application/json", headerParams: nil, type: .planets, body: nil)
        
        networkManager.execute(request: request, completion: { (result: (Result<PlanetsResponseModel, NetworkError>)) in
            
        })
        
        XCTAssert(dataTask.resumeWasCalled)
    }
}
