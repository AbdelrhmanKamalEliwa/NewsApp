//
//  OnboardingRouter.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import UIKit

class OnboardingRouter: OnBoardingRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = OnboardingVC()
        let router = OnboardingRouter()
        let presenter = OnboardingPresenter(view: view, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToHomeVC(
        from view: OnBoardingViewProtocol?,
        countryCode: String,
        categories: [Categories]
    ) {
        let homeVC = HeadlinesRouter.createModule(countryCode: countryCode, categories: categories)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}
