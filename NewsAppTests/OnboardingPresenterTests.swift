//
//  OnboardingTests.swift
//  NewsAppTests
//
//  Created by Abdelrhman Eliwa on 13/08/2021.
//

import XCTest

@testable import NewsApp
class OnboardingPresenterTests: XCTestCase {

    var sut: OnboardingPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        let view = OnboardingVC()
        let router = OnboardingRouter()
        sut = OnboardingPresenter(view: view, router: router)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: Test the Country Code to check if the user did select a country or not
    func testDidSelectCountry() {
        let countryCode = "ar"
        sut.didSelectCountry(with: countryCode)
        let result = sut.validateCountryCode()
        
        XCTAssertTrue(result)
    }
    
    // MARK: Test the Categories to check if the user did select at least 3 different categories or not
    func testDidTapCategoriesButtons() {
        // identifier must be false
        // tag must be diferent values from 1 to 7
        let identifier = "false"
        sut.didTapCategoriesButtons(for: 1, with: identifier)
        sut.didTapCategoriesButtons(for: 2, with: identifier)
        sut.didTapCategoriesButtons(for: 7, with: identifier)
        let result = sut.validateCategories()
        
        XCTAssertTrue(result)
    }
    
}
