//
//  NavbarProtocol.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 05/05/2021.
//

import UIKit

protocol DefaultNavbarProtocol {
    func setupNavbarDefaultUI()
}

protocol CustomeNavbarProtocol {
    func setupCustomeNavbar(with title: String?)
    func hideCustomeNavbar()
}

extension CustomeNavbarProtocol where Self: UIViewController {
    private var navbar: UINavigationBar? {
        return self.navigationController?.navigationBar
    }
    
    func setupCustomeNavbar(with title: String? = nil) {
        navbar?.isHidden = false
        navbar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar?.shadowImage = UIImage()
        navbar?.prefersLargeTitles = false
        navbar?.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sfProText(.medium, ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor(named: "AppBlack")!
        ]
        navbar?.tintColor = UIColor(named: "AppBlack")!
        navbar?.barTintColor = .white
        navigationItem.title = title
    }
    
    func hideCustomeNavbar() {
        navbar?.isHidden = true
    }
}

extension DefaultNavbarProtocol where Self: UIViewController {
    private var navbar: UINavigationBar? {
        return self.navigationController?.navigationBar
    }
    
    func setupNavbarDefaultUI() {
        navbar?.barTintColor = .clear
        navbar?.tintColor = .clear
        navbar?.prefersLargeTitles = false
        navbar?.isHidden = true
    }
}
