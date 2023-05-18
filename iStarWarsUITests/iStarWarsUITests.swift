//
//  iStarWarsUITests.swift
//  iStarWarsUITests
//
//  Created by Venkata Sivannarayana Golla on 15/05/23.
//

import XCTest
import CoreData
@testable import iStarWarsMock

class iStarWarsUITests: XCTestCase {

    var application: XCUIApplication!
    
    override func setUpWithError() throws {
        application = XCUIApplication()
        application.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        
        let homeTableView = application.tables["homeView"]
        XCTAssertTrue(homeTableView.waitForExistence(timeout: 10))
        XCTAssertTrue(homeTableView.exists)
        XCTAssertTrue(homeTableView.cells.count > 0)
    }
}
