//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Ahmed Hassan on 09/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var mainRouter: MainRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupMainRouter()
        return true
    }
    
    private func setupMainRouter() {
        mainRouter = MainRouter()
        var initialVC = UINavigationController()
        let onboardingVC = OnboardingRouter.createModule()
        let homeVC = UIViewController()
        if UserDataManager.shared.didUserSeeOnboardingScreen {
            initialVC = UINavigationController(rootViewController: onboardingVC)
        } else {
            initialVC = UINavigationController(rootViewController: onboardingVC)
        }
        mainRouter?.start(with: initialVC)
    }
}
