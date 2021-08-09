//
//  UserDataManager.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 06/06/2021.
//

import Foundation

class UserDataManager {
    
    static let shared = UserDataManager()
    private let userDefault = UserDefaults.standard
    
    private init() {}
    
    var didUserSeeOnboardingScreen: Bool {
        if let value = userDefault.object(forKey: "userDidSeeOnboardingScreen") as? Bool {
            return value ? true : false
        } else {
            return false
        }
    }
    
    func userDidSeeOnboardingScreen() {
        userDefault.setValue(true, forKey: "userDidSeeOnboardingScreen")
    }
}
