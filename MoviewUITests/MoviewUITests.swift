//
//  MoviewUITests.swift
//  MoviewUITests
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//

import XCTest

class MoviewUITests: XCTestCase {

    override func setUp() {
        XCUIApplication().launch()
    }

    //MARK: Test Validate Views
    func testExistViews() {
        let app = XCUIApplication()
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        let moviesItem = tabBar.buttons["Movies"]
        XCTAssertTrue(moviesItem.exists)
        let favItem = tabBar.buttons["Favorites"]
        XCTAssertTrue(favItem.exists)
        let infoItem = tabBar.buttons["Info"]
        XCTAssertTrue(infoItem.exists)
        let tables = app.tables.element
        XCTAssertTrue(tables.exists)
    }
    
    //MARK: Test Navigation
    func testTapItemSuccess(){
        let app = XCUIApplication()
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favorites"].tap()
        let labelFav = app.staticTexts["Your favorite movies"]
        XCTAssertTrue(labelFav.exists)
        tabBar.buttons["Info"].tap()
        let labelInfo = app.staticTexts["Information"]
        XCTAssertTrue(labelInfo.exists)
        tabBar.buttons["Movies"].tap()
        let labelHome =  app.staticTexts["Get to know the most popular movies, and save the ones you like as favorites"]
        XCTAssertTrue(labelHome.exists)
    }
    
    //MARK: Test Navigation
    ///This test only works with network
    func testNavigate(){
        let app = XCUIApplication()
        sleep(4)
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.tap()
        let navBarDetail = app.navigationBars["Moview.MovieDetailView"]
        XCTAssertTrue(navBarDetail.exists)
    }
    
}
