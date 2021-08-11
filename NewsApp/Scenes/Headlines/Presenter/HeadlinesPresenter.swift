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
    private var category: String = ""
    private var cachedData: [Articles] = []
    private var searchData: NewsModel?
    private var totalCount: Int = 0
    private var dataSource: [ArticleModel] = []
    private var searchDataSource: [ArticleModel] {
        searchData?.articles ?? []
    }
    private var pageSize: Int = 20
    private var page: Int = 1
    private var isSearching: Bool = false
    private var cacheStatus: Bool = false
    var numberOfRows: Int {
        cacheStatus ? cachedData.count : dataSource.count
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
        category = getCategoriesTitles().first!
        view?.setupSegmentedControll(with: getCategoriesTitles())
        view?.setupSearchBar()
        view?.setupTableView()
        view?.setupRefreshController()
        fetchData()
    }
    
    func viewWillAppear() {
        view?.setupNavbar()
    }
    
    func cellConfiguration(_ cell: HeadlineCellProtocol, for indexPath: IndexPath) {
        if cacheStatus {
            let cachedModel = cachedData[indexPath.row]
            let model: ArticleModel = ArticleModel(
                source: SourceModel(id: nil, name: cachedModel.source),
                title: cachedModel.title,
                description: cachedModel.articleDescription,
                urlToImage: cachedModel.urlToImage,
                publishedAt: cachedModel.publishedAt,
                url: cachedModel.url
            )
            cell.configure(model: model)
        } else {
            var model: ArticleModel?
            model = isSearching ? searchDataSource[indexPath.row] : dataSource[indexPath.row]
            guard let model = model else { return }
            cell.configure(model: model)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard !cacheStatus else {
            view?.showError(
                with: "No Internet Connection",
                message: "Please check your internet connection and try again"
            )
            return
        }
        var model: ArticleModel?
        model = isSearching ? searchDataSource[indexPath.row] : dataSource[indexPath.row]
        guard
            let stringUrl = model?.url,
            let url = URL(string: stringUrl)
        else {
            view?.showError(with: "Invalid URL", message: "Can't open the atricle on Safari")
            return
        }
        router.navigateToSafariVC(form: view, with: url)
    }
    
    func didTapSegmentedControl(for title: String?) {
        guard let title = title else { return }
        category = title.lowercased()
        fetchData()
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        guard !isSearching, !cacheStatus else { return }
        guard
            dataSource.count < totalCount, indexPath.row >= dataSource.count - 1
        else { return }
        page += 1
        interactor.fetchData(
            country: countryCode,
            category: category,
            pageSize: pageSize,
            page: page
        )
    }
    
    func search(for text: String?) {
        guard let text = text else { return }
        isSearching = true
        view?.showLoadingAnimation()
        interactor.search(for: text)
    }
    
    func searchBarCancelButtonClicked() {
        isSearching = false
        view?.fetchDataSuccess()
    }
    
    func scrollViewDidScroll(status: Bool) {
        view?.animateUI(status)
    }
    
    func refreshData() {
        page = 1
        fetchData()
    }
    
    private func fetchData() {
        view?.showLoadingAnimation()
        interactor.fetchData(
            country: countryCode,
            category: category,
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
   
    func searchDataFetchedSuccessfully(_ data: NewsModel) {
        view?.hideLoadingAnimation()
        searchData = data
        view?.fetchDataSuccess()
    }
    
    func dataFetchedSuccessfully(_ data: NewsModel) {
        view?.hideLoadingAnimation()
        if !data.articles.isEmpty {
            dataSource.append(contentsOf: data.articles)
        }
        self.totalCount = data.totalResults
        cacheStatus = false
        interactor.cacheData(data.articles, pageIndex: page)
        view?.fetchDataSuccess()
    }
    
    func dataFetchingFailed(withError error: Error?) {
        view?.hideLoadingAnimation()
        view?.showError(with: "Error", message: error?.localizedDescription ?? "")
    }
    
    func noInternetConnection() {
        view?.updateUIForInternetConnection(false)
        cacheStatus = true
        interactor.loadCachedData()
    }
    
    func coreDataResponseSuccessfully(_ data: [Articles]?) {
        cachedData = data ?? []
        view?.fetchDataSuccess()
    }
    
    func coreDataResponseFailed(_ error: Error?) {
        guard let error = error else { return }
        view?.showError(with: "Error", message: error.localizedDescription)
    }
}
