//
//  EndPointRouter.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct EndPointRouter {
    static var getNews: URL { return URL(string: NewsAPIService.baseURL())! }
    
//    static func getNews(country: Countries) -> URL {
//        return URL(string: NewsAPIService.baseURL() + "&country=" + country.rawValue + "&category=health")!
//    }
//
//    static var getCountriesData: URL {
//        return URL(string: StatisticsAPIService.baseURL())!
//    }
}
