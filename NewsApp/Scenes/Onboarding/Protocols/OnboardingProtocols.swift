//
//  OnboardingProtocols.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import Foundation

protocol OnBoardingViewProtocol: AnyObject {
    var presenter: OnBoardingPresenterProtocol! { get set }
    func setupUI()
    func setLocalizedStrings()
    func setupNavbar()
    func updateCategoriesButtonsUI(
        for buttonIndex: Int,
        accessibilityIdentifier identifier: String,
        imageName name: String
    )
    func showError(with title: String, message: String)
}

protocol OnBoardingPresenterProtocol: AnyObject {
    var view: OnBoardingViewProtocol? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubViews()
    func didTapCategoriesButtons(for tag: Int, with identifier: String?)
    func didTapStartButton()
    func didSelectCountry(with code: String)
}

protocol OnBoardingRouterProtocol {
    func navigateToHomeVC(
        from view: OnBoardingViewProtocol?,
        countryCode: String,
        categories: [Categories]
    )
}
