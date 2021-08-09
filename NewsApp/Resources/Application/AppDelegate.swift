//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Ahmed Hassan on 09/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let view = UIViewController()
        view.view.backgroundColor = .red
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        return true
    }
}

