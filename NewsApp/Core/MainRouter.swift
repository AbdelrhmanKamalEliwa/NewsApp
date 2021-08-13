//
//  MainRouter.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 05/05/2021.
//

import UIKit

class MainRouter {
    func setInitialVC() -> UIViewController {
        let onboardingVC = OnboardingRouter.createModule()
        let countryCode = UserDataManager.shared.countryCode
        let categories = UserDataManager.shared.categories
        let headlinesVC = HeadlinesRouter.createModule(countryCode: countryCode, categories: categories)
        return UserDataManager.shared.didUserSeeOnboardingScreen ? headlinesVC : onboardingVC
    }
}
