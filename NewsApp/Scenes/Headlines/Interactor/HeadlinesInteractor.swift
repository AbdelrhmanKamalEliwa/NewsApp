//
//  HeadlinesInteractor.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import Foundation

class HeadlinesInteractor: HeadlinesInteractorInputProtocol {
    
    weak var presenter: HeadlinesInteractorOutputProtocol?
    private let networkManager = NetworkManager()
    
    func fetchData(text: String?, country: String, category: String, pageSize: Int, page: Int) {
        let url: URL = EndPointRouter.getHeadlines(
            country: country,
            category: category,
            pageSize: pageSize,
            page: page,
            sortBy: "date"
        )
        _ = networkManager.request(
            url: url,
            httpMethod: .get,
            parameters: nil,
            headers: nil
        ) { [weak self] (result: APIResult<NewsModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.presenter?.dataFetchedSuccessfully(data)
            case .failure(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            case .decodingFailure(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            case .badRequest(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            }
        }
    }
}
