//
//  iStarWarsUITestsLaunchTests.swift
//  iStarWarsUITests
//
//  Created by Venkata Sivannarayana Golla on 15/05/23.
//

import XCTest
import CoreData
@testable import iStarWarsMock

extension XCUIApplication {

    var isDisplayingHomeScreen: Bool {
        return otherElements["homeView"].exists
    }
}

class iStarWarsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
