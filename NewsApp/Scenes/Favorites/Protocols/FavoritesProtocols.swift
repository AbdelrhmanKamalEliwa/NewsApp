//
//  FavoritesProtocols.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
    var presenter: FavoritesPresenterProtocol! { get set }
    func setupNavbar()
    func setupTableView()
    func fetchDataSuccess()
    func deleteRowFromTableView(at indexPath: IndexPath)
    func showError(with title: String, message: String)
}

protocol FavoritesPresenterProtocol: AnyObject {
    var view: FavoritesViewProtocol? { get set }
    var numberOfRows: Int { get }
    func viewDidLoad()
    func viewWillAppear()
    func cellConfiguration(_ cell: HeadlineCellProtocol, for indexPath: IndexPath)
    func didSwipeToRemoveArticle(at indexPath: IndexPath)
}

protocol FavoritesInteractorInputProtocol {
    var presenter: FavoritesInteractorOutputProtocol? { get set }
    func fetchFavorites()
    func deleteArticle(_ articleId: String)
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func favoritesFetchedSuccessfully(_ data: [FavoriteArticles])
    func favoritesFetchingFailed(withError error: Error?)
    func deleteArticleFetchedSuccessfully(_ articleId: String)
    func deleteArticleFetchingFailed(_ error: Error?)
}

protocol FavoritesRouterProtocol {
    func presentSafariVC(form view: HeadlinesViewProtocol?, with url: URL)
    func dismiss(_ view: FavoritesViewProtocol?)
}
