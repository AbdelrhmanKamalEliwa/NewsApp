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
    
    static func getCategoriesTitles(_ categories: [Categories]) -> [String] {
        var titles: [String] = []
        categories.forEach { category in
            switch category {
            case .business:
                titles.append("business")
            case .entertainment:
                titles.append("entertainment")
            case .general:
                titles.append("general")
            case .health:
                titles.append("health")
            case .science:
                titles.append("science")
            case .sports:
                titles.append("sports")
            case .technology:
                titles.append("technology")
            }
        }
        return titles
    }
}

class OnboardingPresenter: OnBoardingPresenterProtocol {
    
    // MARK: - Properties
    weak var view: OnBoardingViewProtocol?
    private let router: OnBoardingRouterProtocol
    private var countryCode: String = ""
    private var categories: [Categories] = []
    
    // MARK: - Init
    init(view: OnBoardingViewProtocol?, router: OnBoardingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods
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
    
    func validateCountryCode() -> Bool {
        guard !countryCode.isEmpty  else {
            view?.showError(
                with: "Select Favorite Country",
                message: "You should select your favorite country to start"
            )
            return false
        }
        return true
    }
    
    func validateCategories() -> Bool {
        guard categories.count == 3 else {
            view?.showError(
                with: "Select Categories",
                message: "You should select at least, no more, 3 categories to start"
            )
            return false
        }
        return true
    }
    
    func didTapStartButton() {
        guard validateCountryCode(), validateCategories() else { return }
        UserDataManager.shared.setCountryCode(countryCode)
        UserDataManager.shared.setCategories(categories)
        UserDataManager.shared.userDidSeeOnboardingScreen()
        router.navigateToHomeVC(from: view, countryCode: countryCode, categories: categories)
    }
    
    func didSelectCountry(with code: String) {
        countryCode = code.lowercased()
    }
    
}
