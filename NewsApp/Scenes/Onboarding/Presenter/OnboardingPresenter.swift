//
//  OnboardingPresenter.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import Foundation

enum Categories: Int {
    case business = 1
    case entertainment = 2
    case general = 3
    case health = 4
    case science = 5
    case sports = 6
    case technology = 7
}

class OnboardingPresenter: OnBoardingPresenterProtocol {
    
    weak var view: OnBoardingViewProtocol?
    private let router: OnBoardingRouterProtocol
    private var countryCode: String = ""
    private var categories: [Categories] = []
    init(view: OnBoardingViewProtocol?, router: OnBoardingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupUI()
    }
    
    func viewWillAppear() {
        view?.setupNavbar()
    }
    
    func didTapCategoriesButtons(for tag: Int, with identifier: String?) {
        if identifier == "true" {
            view?.updateCategoriesButtonsUI(
                for: tag - 1, accessibilityIdentifier: "false", imageName: "square"
            )
            categories.removeAll(where: {$0.rawValue == tag})
        } else {
            view?.updateCategoriesButtonsUI(
                for: tag - 1, accessibilityIdentifier: "true", imageName: "checkmark.square.fill"
            )
            if let category = Categories(rawValue: tag) {
                categories.append(category)
            }
        }
    }
    
    func didTapStartButton() {
        
        guard !countryCode.isEmpty  else {
            view?.showError(
                with: "Select Favorite Country",
                message: "You should select your favorite country to start"
            )
            return
        }
        
        guard categories.count == 3 else {
            view?.showError(
                with: "Select Categories",
                message: "You should select at least, no more, 3 categories to start"
            )
            return
        }
        
        router.navigateToHomeVC(from: view, countryCode: countryCode, categories: categories)
    }
    
    func didSelectCountry(with code: String) {
        countryCode = code.lowercased()
    }
    
}
