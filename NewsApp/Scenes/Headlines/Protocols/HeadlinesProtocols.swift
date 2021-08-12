//
//  HeadlinesProtocols.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import Foundation

protocol HeadlinesViewProtocol: AnyObject {
    var presenter: HeadlinesPresenterProtocol! { get set }
    func setupSegmentedControll(with titles: [String])
    func setupSearchBar()
    func setupNavbar()
    func setupTableView()
    func setupRefreshController()
    func fetchDataSuccess()
    func showLoadingAnimation()
    func hideLoadingAnimation()
    func showError(with title: String, message: String)
    func updateUIForInternetConnection(_ isConnected: Bool)
    func animateUI(_ status: Bool)
}

protocol HeadlineCellProtocol {
    func configure(model: ArticleModel)
}

protocol HeadlinesPresenterProtocol: AnyObject {
    var view: HeadlinesViewProtocol? { get set }
    var numberOfRows: Int { get }
    func viewDidLoad()
    func viewWillAppear()
    func cellConfiguration(_ cell: HeadlineCellProtocol, for indexPath: IndexPath)
    func didSelectItem(at indexPath: IndexPath)
    func willDisplayCell(at indexPath: IndexPath)
    func didTapSegmentedControl(for title: String?)
    func search(for text: String?)
    func searchBarCancelButtonClicked()
    func scrollViewDidScroll(status: Bool)
    func refreshData()
    func didTapFavoritesButton()
    func didSwipeToAddToFavorites(at indexPath: IndexPath)
}

protocol HeadlinesInteractorInputProtocol {
    var presenter: HeadlinesInteractorOutputProtocol? { get set }
    func fetchData(country: String, category: String, pageSize: Int, page: Int, isPaginated: Bool)
    func search(for text: String)
    func cacheData(_ data: [ArticleModel], pageIndex: Int)
    func loadCachedData()
    func addToFavorites(_ article: ArticleModel, articleId: String)
}

protocol HeadlinesInteractorOutputProtocol: AnyObject {
    func dataFetchedSuccessfully(_ data: NewsModel, isPaginated: Bool)
    func searchDataFetchedSuccessfully(_ data: NewsModel)
    func dataFetchingFailed(withError error: Error?)
    func noInternetConnection()
    func coreDataResponseSuccessfully(_ data: [Articles]?)
    func coreDataResponseFailed(_ error: Error?)
    func articleAddedToFavoritesSuccessfully()
}

protocol HeadlinesRouterProtocol {
    func presentSafariVC(form view: HeadlinesViewProtocol?, with url: URL)
    func presentFavoritesVC(from view: HeadlinesViewProtocol?)
}
