//
//  PulseGuardAIUITests.swift
//  PulseGuardAIUITests
//
//  Created for SE4041 MADD Assignment 2.
//

import XCTest

final class PulseGuardAIUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    /// Verifies core tab navigation between Today, AI Intel, Logs & Trends, and Recovery Map
    func testTabNavigationFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // 1. Verify Today Dashboard screen
        XCTAssertTrue(app.navigationBars["PulseGuard AI"].waitForExistence(timeout: 4.0))

        // 2. Navigate to AI Intel Tab
        let aiTab = app.tabBars.buttons["AI Intel"]
        if aiTab.exists {
            aiTab.tap()
            XCTAssertTrue(app.navigationBars["AI Intelligence"].waitForExistence(timeout: 2.0))
        }

        // 3. Navigate to Logs & Trends Tab
        let logsTab = app.tabBars.buttons["Logs & Trends"]
        if logsTab.exists {
            logsTab.tap()
            XCTAssertTrue(app.navigationBars["Vitals History"].waitForExistence(timeout: 2.0))
        }

        // 4. Navigate to Recovery Map Tab
        let mapTab = app.tabBars.buttons["Recovery Map"]
        if mapTab.exists {
            mapTab.tap()
            XCTAssertTrue(app.navigationBars["Wellness Radar"].waitForExistence(timeout: 2.0))
        }
    }

    /// Verifies that tapping the Guided Breathing action presents the modal sheet
    func testGuidedBreathingModalPresentation() throws {
        let app = XCUIApplication()
        app.launch()

        let breathingButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Reduce Acute Stress'")).firstMatch
        if breathingButton.waitForExistence(timeout: 3.0) {
            breathingButton.tap()
            let modalTitle = app.staticTexts["Parasympathetic Reset"]
            XCTAssertTrue(modalTitle.waitForExistence(timeout: 2.0))

            let closeButton = app.buttons["Close"]
            if closeButton.exists {
                closeButton.tap()
            }
        }
    }
}
