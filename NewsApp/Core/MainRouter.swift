//
//  MainRouter.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 05/05/2021.
//

import UIKit

class MainRouter {
    
    private var rootViewController: UIViewController?
    let window: UIWindow
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    func start(with rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func setRootViewController(viewController: UIViewController) {
        rootViewController = viewController
    }
    
    func getRootViewController() -> UIViewController? {
        rootViewController
    }
}
