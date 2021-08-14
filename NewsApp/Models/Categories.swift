//
//  Categories.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 13/08/2021.
//

import Foundation

enum Categories: Int {
    case business = 1
    case entertainment = 2
    case general = 3
    case health = 4
    case science = 5
    case sports = 6
    case technology = 7
    
    static func getCategoriesTitles(_ categories: [Categories]) -> [String] {
        var titles: [String] = []
        categories.forEach { category in
            switch category {
            case .business:
                titles.append("business")
            case .entertainment:
                titles.append("entertainment")
            case .general:
                titles.append("general")
            case .health:
                titles.append("health")
            case .science:
                titles.append("science")
            case .sports:
                titles.append("sports")
            case .technology:
                titles.append("technology")
            }
        }
        return titles
    }
    
    static func getTitle(for tag: Int) -> String {
        switch self.init(rawValue: tag) {
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .general:
            return "General"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        case .none:
            return ""
        }
    }
}
