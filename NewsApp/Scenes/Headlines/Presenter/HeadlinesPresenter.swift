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
        fetchData(isPaginated: false)
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
        router.presentSafariVC(form: view, with: url)
    }
    
    func didTapSegmentedControl(for title: String?) {
        guard let title = title else { return }
        category = title.lowercased()
        fetchData(isPaginated: false)
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
            page: page,
            isPaginated: true
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
        fetchData(isPaginated: false)
    }
    
    func didTapFavoritesButton() {
        router.navigateToFavoritesVC(from: view)
    }
    
    func didSwipeToAddToFavorites(at indexPath: IndexPath) {
        cacheStatus ? addCachedArticleToFavorites(at: indexPath) : addArticleToFavorites(at: indexPath)
    }
    
    private func addArticleToFavorites(at indexPath: IndexPath) {
        var article: ArticleModel?
        article = isSearching ? searchDataSource[indexPath.row] : dataSource[indexPath.row]
        guard let article = article else { return }
        let articleId =
            (article.publishedAt ?? "") +
            (article.source.id ?? "") +
            (article.source.name ?? "") +
            ("\(Int.random(in: 0...1000))")
        interactor.addToFavorites(article, articleId: articleId)
    }
    
    private func addCachedArticleToFavorites(at indexPath: IndexPath) {
        let cachedArticle = cachedData[indexPath.row]
        let article: ArticleModel = ArticleModel(
            source: SourceModel(id: nil, name: cachedArticle.source),
            title: cachedArticle.title,
            description: cachedArticle.articleDescription,
            urlToImage: cachedArticle.urlToImage,
            publishedAt: cachedArticle.publishedAt,
            url: cachedArticle.url
        )
        let articleId =
            (article.publishedAt ?? "") +
            (article.source.id ?? "") +
            (article.source.name ?? "") +
            ("\(Int.random(in: 0...1000))")
        interactor.addToFavorites(article, articleId: articleId)
    }
    
    private func fetchData(isPaginated: Bool) {
        view?.showLoadingAnimation()
        interactor.fetchData(
            country: countryCode,
            category: category,
            pageSize: pageSize,
            page: page,
            isPaginated: isPaginated
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
    
    func dataFetchedSuccessfully(_ data: NewsModel, isPaginated: Bool) {
        view?.hideLoadingAnimation()
        if !data.articles.isEmpty {
            if isPaginated {
                dataSource.append(contentsOf: data.articles)
            } else {
                dataSource = data.articles
            }
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
    
    func articleAddedToFavoritesSuccessfully() {
        view?.showError(
            with: "Success",
            message: "Article has been added to favorites successfully"
        )
    }
}
