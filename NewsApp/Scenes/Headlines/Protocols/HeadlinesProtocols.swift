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
    func fetchDataSuccess()
    func showLoadingAnimation()
    func hideLoadingAnimation()
    func showError(with title: String, message: String)
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
}

protocol HeadlinesInteractorInputProtocol {
    var presenter: HeadlinesInteractorOutputProtocol? { get set }
    func fetchData(country: String, category: String, pageSize: Int, page: Int)
    func search(for text: String)
}

protocol HeadlinesInteractorOutputProtocol: AnyObject {
    func dataFetchedSuccessfully(_ data: NewsModel)
    func searchDataFetchedSuccessfully(_ data: NewsModel)
    func dataFetchingFailed(withError error: Error?)
}

protocol HeadlinesRouterProtocol {
    func navigateToSafariVC(form view: HeadlinesViewProtocol?, with url: URL)
}
