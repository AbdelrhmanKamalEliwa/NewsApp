//
//  FavoritesPresenter.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//

import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    // MARK: - Properties
    weak var view: FavoritesViewProtocol?
    private let interactor: FavoritesInteractorInputProtocol
    private let router: FavoritesRouterProtocol
    private var dataSource: [FavoriteArticles] = []
    private var indexPathToDelete: IndexPath!
    var numberOfRows: Int {
        dataSource.count
    }
    
    // MARK: - Init
    init(
        view: FavoritesViewProtocol,
        interactor: FavoritesInteractorInputProtocol,
        router: FavoritesRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupTableView()
        fetchData()
    }
    
    func viewWillAppear() {
        view?.setupNavbar()
    }
    
    func cellConfiguration(_ cell: HeadlineCellProtocol, for indexPath: IndexPath) {
        let favoriteArticle = dataSource[indexPath.row]
        let model: ArticleModel = ArticleModel(
            source: SourceModel(id: nil, name: favoriteArticle.source),
            title: favoriteArticle.title,
            description: favoriteArticle.articleDescription,
            urlToImage: favoriteArticle.urlToImage,
            publishedAt: favoriteArticle.publishedAt,
            url: favoriteArticle.url
        )
        cell.configure(model: model)
    }
    
    func didSwipeToRemoveArticle(at indexPath: IndexPath) {
        guard let articleId = dataSource[indexPath.row].articleId else {
            view?.showError(with: "Error", message: "Faild to delete article")
            return
        }
        indexPathToDelete = indexPath
        interactor.deleteArticle(articleId)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard
            let stringUrl = dataSource[indexPath.row].url,
            let url = URL(string: stringUrl) else {
            view?.showError(with: "Invalid URL", message: "Can't open the atricle on Safari")
            return
        }
        router.presentSafariVC(form: view, with: url)
    }
    
    private func fetchData() {
        interactor.fetchFavorites()
    }
    
    private func sortDataByDate() {
        dataSource.sort {
            $0.publishedAt!.convertToDate(
                formatter: "yyyy-MM-dd'T'HH:mm:ssZZZ"
            ) > $1.publishedAt!.convertToDate(
                formatter: "yyyy-MM-dd'T'HH:mm:ssZZZ"
            )
        }
    }
}

// MARK: - Interactor Response
extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    
    func favoritesFetchedSuccessfully(_ data: [FavoriteArticles]) {
        dataSource = data
        sortDataByDate()
        view?.fetchDataSuccess()
    }
    
    func favoritesFetchingFailed(withError error: Error?) {
        view?.showError(with: "Error", message: error?.localizedDescription ?? "")
    }
    
    func deleteArticleFetchedSuccessfully(_ articleId: String) {
        dataSource.remove(at: indexPathToDelete.row)
        view?.deleteRowFromTableView(at: indexPathToDelete)
    }
    
    func deleteArticleFetchingFailed(_ error: Error?) {
        view?.showError(with: "Error", message: "Failed to delete article")
    }
}
