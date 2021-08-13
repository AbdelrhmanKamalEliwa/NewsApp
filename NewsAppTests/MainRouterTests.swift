//
//  MainRouterTests.swift
//  NewsAppTests
//
//  Created by Abdelrhman Eliwa on 13/08/2021.
//

import XCTest

@testable import NewsApp
class MainRouterTests: XCTestCase {

    var sut: MainRouter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = MainRouter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSetInitialVC() {
        let result = sut.setInitialVC()
        let expression = UserDataManager.shared.didUserSeeOnboardingScreen ? result is HeadlinesVC : result is OnboardingVC
        XCTAssertTrue(expression)
    }

}
