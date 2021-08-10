//
//  HeadlinesPresenter.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import Foundation

class HeadlinesPresenter: HeadlinesPresenterProtocol {
    
    // MARK: - Properties
    weak var view: HeadlinesViewProtocol?
    private let interactor: HeadlinesInteractorInputProtocol
    private let router: HeadlinesRouterProtocol
    private let countryCode: String
    private let categories: [Categories]
    private var data: NewsModel?
    private var totalCount: Int = 0
    private var dataSource: [ArticleModel] {
        data?.articles ?? []
    }
    private var pageSize: Int = 20
    private var page: Int = 0
    var numberOfRows: Int {
        dataSource.count
    }
    
    // MARK: - Init
    init(
        view: HeadlinesViewProtocol,
        interactor: HeadlinesInteractorInputProtocol,
        router: HeadlinesRouterProtocol,
        countryCode: String,
        categories: [Categories]
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.countryCode = countryCode
        self.categories = categories
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupSegmentedControll(with: getCategoriesTitles())
        view?.setupSearchBar()
        view?.setupTableView()
        fetchData()
    }
    
    func viewWillAppear() {
        view?.setupNavbar()
    }
    
    func cellConfiguration(_ cell: HeadlineCellProtocol, for indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        cell.configure(model: model)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
    func didTapSegmentedControl() {
        
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        guard
            dataSource.count < totalCount, indexPath.row >= dataSource.count - 1
        else { return }
        page += 1
        interactor.fetchData(
            text: nil,
            country: countryCode,
            category: getCategoriesTitles().first!,
            pageSize: pageSize,
            page: page
        )
    }
    
    private func fetchData() {
        view?.showLoadingAnimation()
        interactor.fetchData(
            text: nil,
            country: countryCode,
            category: getCategoriesTitles().first!,
            pageSize: pageSize,
            page: page
        )
    }
    
    private func getCategoriesTitles() -> [String] {
        var titles: [String] = []
        categories.forEach { category in
            switch category {
            case .business:
                titles.append("business")
            case .entertainment:
                titles.append("entertainment")
            case .general:
                titles.append("general")
            case .health:
                titles.append("health")
            case .science:
                titles.append("science")
            case .sports:
                titles.append("sports")
            case .technology:
                titles.append("technology")
            }
        }
        return titles
    }
}

// MARK: - Interactor Response
extension HeadlinesPresenter: HeadlinesInteractorOutputProtocol {
    func dataFetchedSuccessfully(_ data: NewsModel) {
        view?.hideLoadingAnimation()
        if !data.articles.isEmpty { self.data = data }
        self.totalCount = data.totalResults
        view?.fetchDataSuccess()
    }
    
    func dataFetchingFailed(withError error: Error?) {
        view?.hideLoadingAnimation()
        view?.showError(with: "Error", message: error?.localizedDescription ?? "")
    }
}
