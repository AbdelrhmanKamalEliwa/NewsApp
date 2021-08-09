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
    
    var isLoggedIn: Bool {
        ((getData()["userId"] as? String) != nil) ? true : false
    }
    
    func cacheData(userInfo: [String: Any?]) {
       
        var user = [String: Any]()
        
        if !getData().isEmpty {
            user = getData()
        }
        if let userId = userInfo["userId"] {
            user["userId"] = userId
        }
        if let firstName = userInfo["firstName"] {
            user["firstName"] = firstName
        }
        if let lastName = userInfo["lastName"] {
            user["lastName"] = lastName
        }
        if let email = userInfo["email"] {
            user["email"] = email
        }
        if let phoneNumber = userInfo["phoneNumber"] {
            user["phoneNumber"] = phoneNumber
        }
        if let profileImage = userInfo["profileImage"] {
            user["profileImage"] = profileImage
        }
        if let accessToken = userInfo["accessToken"] {
            user["accessToken"] = accessToken
        }
        if let refreshToken = userInfo["refreshToken"] {
            user["refreshToken"] = refreshToken
        }
        if let creditCard = userInfo["creditCard"] {
            user["creditCard"] = creditCard
        }
        userDefault.setValue(user, forKey: "user")
        userDefault.synchronize()
    }
    
    func getData() -> [String: Any] {
        if let user = userDefault.value(forKey: "user") as? [String: Any] {
            return user
        } else {
            return [:]
        }
    }
}
