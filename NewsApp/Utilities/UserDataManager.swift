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
    
    var categories: [Categories] {
        var tempCategories: [Categories] = []
        if let categoriesArray = userDefault.object(forKey: "categories") as? [Int] {
            categoriesArray.forEach { category in
                switch Categories(rawValue: category) {
                case .business:
                    tempCategories.append(.business)
                case .entertainment:
                    tempCategories.append(.entertainment)
                case .general:
                    tempCategories.append(.general)
                case .health:
                    tempCategories.append(.health)
                case .science:
                    tempCategories.append(.science)
                case .sports:
                    tempCategories.append(.sports)
                case .technology:
                    tempCategories.append(.technology)
                case .none:
                    return
                }
            }
            return tempCategories
        } else {
            return tempCategories
        }
    }
    
    var countryCode: String {
        userDefault.object(forKey: "countryCode") as? String ?? ""
    }
    
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
    
    func setCountryCode(_ code: String) {
        userDefault.setValue(code.lowercased(), forKey: "countryCode")
    }
    
    func setCategories(_ categories: [Categories]) {
        var categoriesArray: [Int] = []
        categories.forEach({categoriesArray.append($0.rawValue)})
        userDefault.setValue(categoriesArray, forKey: "categories")
    }
}
