//
//  MainRouter.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 05/05/2021.
//

import UIKit

class MainRouter {
    
    private(set) var rootViewController: UIViewController?
    private(set) var window: UIWindow
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    /// This func helps you to initilize the window and setting the rootViewControllerr
    /// - Parameter rootViewController: rootViewController
    func start(with rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    /// This func helps you to override rootViewController and setting a new one
    /// - Parameter viewController: new rootViewController
    func setRootViewController(viewController: UIViewController) {
        rootViewController = viewController
    }
    
    /// This func helps you to override window and setting a new one
    /// - Parameter window: new window
    func setWindow(_ window: UIWindow) {
        self.window = window
    }
}
