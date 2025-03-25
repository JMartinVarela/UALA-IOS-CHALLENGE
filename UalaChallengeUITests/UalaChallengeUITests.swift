//
//  UalaChallengeUITests.swift
//  UalaChallengeUITests
//
//  Created by Juan Martin Varela on 24/03/2025.
//

import XCTest

final class UalaChallengeUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testListSelection() {
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        elementsQuery.buttons["Hurzuf, UA, lat: 44,549999 long: 34,283333"].tap()
        elementsQuery.buttons["Novinki, RU, lat: 55,683334 long: 37,666668"].tap()
        elementsQuery.buttons["Holubynka, UA, lat: 44,599998 long: 33,900002"].tap()
        elementsQuery.buttons["Merida, VE, lat: 8,598333 long: -71,144997"].tap()
        elementsQuery.buttons["Lhasa, CN, lat: 29,650000 long: 91,099998"].tap()
        elementsQuery.buttons["Istanbul, TR, lat: 41,035080 long: 28,983311"].tap()
    }
}
