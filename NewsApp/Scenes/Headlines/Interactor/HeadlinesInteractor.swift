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
    private let coreDataManager = CoreDataManager()
    
    func fetchData(country: String, category: String, pageSize: Int, page: Int, isPaginated: Bool) {
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
                self.presenter?.dataFetchedSuccessfully(data, isPaginated: isPaginated)
            case .failure(let error):
                self.presenter?.dataFetchingFailed(withError: error)
                self.presenter?.noInternetConnection()
            case .decodingFailure(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            case .badRequest(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            }
        }
    }
    
    func search(for text: String) {
        let url: URL = EndPointRouter.search(for: text, sortBy: "date")
        _ = networkManager.request(
            url: url,
            httpMethod: .get,
            parameters: nil,
            headers: nil
        ) { [weak self] (result: APIResult<NewsModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.presenter?.searchDataFetchedSuccessfully(data)
            case .failure(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            case .decodingFailure(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            case .badRequest(let error):
                self.presenter?.dataFetchingFailed(withError: error)
            }
        }
    }
    
    func cacheData(_ data: [ArticleModel], pageIndex: Int) {
        DispatchQueue.main.async {
            let error = self.coreDataManager.cachArticlesData(data, pageIndex: pageIndex)
            self.presenter?.coreDataResponseFailed(error)
        }
    }
    
    func loadCachedData() {
        DispatchQueue.main.async {
            let result = self.coreDataManager.loadArticles()
            if let data = result.0 {
                self.presenter?.coreDataResponseSuccessfully(data)
            } else {
                self.presenter?.coreDataResponseFailed(result.1)
            }
        }
    }
    
    func addToFavorites(_ article: ArticleModel, articleId: String) {
        DispatchQueue.main.async {
            let error = self.coreDataManager.saveToFavorite(article, articleId: articleId)
            if let error = error {
                self.presenter?.coreDataResponseFailed(error)
            } else {
                self.presenter?.articleAddedToFavoritesSuccessfully()
            }
        }
    }
}
