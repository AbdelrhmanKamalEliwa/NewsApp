//
//  EndPointRouter.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct EndPointRouter {
    
    static func getHeadlines(country: String, category: String, pageSize: Int, page: Int, sortBy: String) -> URL {
        let baseUrl: String = NewsAPIService.headlines.baseURL()
        let country: String = "&country=" + country
        let category: String = "&category=" + category
        let pageSize: String = "&pageSize=" + "\(pageSize)"
        let page: String = "&page=" + "\(page)"
        let sortBy: String = "&sortBy=" + sortBy
        let apiKey: String = "&apiKey=" + NewsAPIEnvironmentPath.development.apiKey()
        let url = URL(string: baseUrl + country + category + pageSize + page + sortBy + apiKey)!
        return url
    }
    
    static func search(for text: String, sortBy: String) -> URL {
        let baseUrl: String = NewsAPIService.everything.baseURL()
        let modelText: String = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? text
        let text: String = "q=" + modelText
        let sortBy: String = "&sortBy=" + sortBy
        let apiKey: String = "&apiKey=" + NewsAPIEnvironmentPath.development.apiKey()
        let url = URL(string: baseUrl + text + sortBy + apiKey)!
        return url
    }
}
