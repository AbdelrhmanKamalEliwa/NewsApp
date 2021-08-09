//
//  NetworkManager.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class NetworkManager {
    
    public let session = URLSession(configuration: .default)
    
    func request<T: Codable>(
        url: URL, httpMethod: HTTPMethod, parameters: Data?,
        headers: [String: String]?, completionHandler: @escaping(_ result: APIResult<T>) -> ())
        -> URLSessionTask {
        
        // defining the type of method
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        // adding parameters to request body
        if parameters != nil {
            urlRequest.httpBody = parameters
        }
        
        // adding header value
        if headers != nil {
            for header in headers! {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
       
        // doing the task
        let task = session.dataTask(with: urlRequest) { (data, _, error) in
            if error != nil {
                completionHandler(.failure(error))
                return
            }
            
            if let safeData = data {
                do {
                    let stringResponse = String.init(data: safeData, encoding: .utf8)
                    guard let jsonData = stringResponse?.data(using: .utf8) else {
                        completionHandler(.decodingFailure(nil))
                        return
                    }
                    
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    completionHandler(.success(decodedData))
                } catch let error {
                    completionHandler(.decodingFailure(error))
                }
            }
        }
        
        task.resume()
        return task
    }
}
