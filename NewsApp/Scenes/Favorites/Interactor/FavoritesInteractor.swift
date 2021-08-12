//
//  FavoritesInteractor.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//

import Foundation

class FavoritesInteractor: FavoritesInteractorInputProtocol {
    
    weak var presenter: FavoritesInteractorOutputProtocol?
    private let coreDataManager = CoreDataManager()
    
    func fetchFavorites() {
        DispatchQueue.main.async {
            let result = self.coreDataManager.loadFavoriteArticles()
            if let data = result.0 {
                self.presenter?.favoritesFetchedSuccessfully(data)
            } else {
                self.presenter?.favoritesFetchingFailed(withError: result.1)
            }
        }
    }
    
    func deleteArticle(_ articleId: String) {
        DispatchQueue.main.async {
            let result = self.coreDataManager.deleteArticleFromFavorites(for: articleId)
            if let articleId = result.0 {
                self.presenter?.deleteArticleFetchedSuccessfully(articleId)
            } else {
                self.presenter?.deleteArticleFetchingFailed(result.1)
            }
        }
    }
}
