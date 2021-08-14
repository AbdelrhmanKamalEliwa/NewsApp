//
//  HeadlinesVC.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import UIKit
import MOLH

class HeadlinesVC: BaseWireframe, CustomeNavbarProtocol {
    
    // MARK: - Properties
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var segmentedControlBottomConstraint: NSLayoutConstraint!
    private let refreshControl = UIRefreshControl()
    var presenter: HeadlinesPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    // MARK: - Methods
    @IBAction private func didTapSegmentedControl(_ sender: UISegmentedControl) {
        presenter.didTapSegmentedControl(for: segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex))
    }
    
    @objc
    private func didTapLocalizationButton() {
        presenter.didTapLocalizationButton()
    }
    
    @objc
    private func didTapFavoritesButton() {
        presenter.didTapFavoritesButton()
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        presenter.refreshData()
        refreshControl.endRefreshing()
    }
}

// MARK: - Scrolling Animation
extension HeadlinesVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.scrollViewDidScroll(
            status: tableView.panGestureRecognizer.translation(in: view).y < 0
        )
    }
}

// MARK: - SearchBar
extension HeadlinesVC: UISearchBarDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.search(for: textField.text)
        view.endEditing(true)
        return false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
        view.endEditing(true)
        presenter.searchBarCancelButtonClicked()
    }
}

// MARK: - Presenter Delegate
extension HeadlinesVC: HeadlinesViewProtocol {
    
    func animateUI(_ status: Bool) {
        searchBar.isHidden = status
        tableViewTopConstraint.constant = status ? 0 : 60
        segmentedControlBottomConstraint.constant = status ? -100 : 20
        UIView.animate(withDuration: 0.5) { self.view.layoutIfNeeded() }
    }
    
    func updateUIForInternetConnection(_ isConnected: Bool) {
        DispatchQueue.main.async {
            self.segmentedControl.isHidden = !isConnected
        }
    }
    
    func setupSegmentedControll(with titles: [String]) {
        segmentedControl.setTitle(titles[0].capitalizingFirstLetter().localized, forSegmentAt: 0)
        segmentedControl.setTitle(titles[1].capitalizingFirstLetter().localized, forSegmentAt: 1)
        segmentedControl.setTitle(titles[2].capitalizingFirstLetter().localized, forSegmentAt: 2)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.placeholder = "HeadlinesVC.searchBar.placeholder".localized
    }
    
    func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh".localized)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setupNavbar() {
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(
            title: "HeadlinesVC.LanguageButton".localized,
            style: .done,
            target: self,
            action: #selector(didTapLocalizationButton)
        )
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .done,
            target: self,
            action: #selector(didTapFavoritesButton)
        )
        setupCustomeNavbar(
            with: "HeadlinesVC.title".localized,
            leftbarButtonItems: [leftBarButtonItem],
            rightbarButtonItems: [rightBarButtonItem]
        )
    }
    
    func fetchDataSuccess() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: HeadlineCell.self)
    }
    
    func showLoadingAnimation() {
        showProgress()
    }
    
    func hideLoadingAnimation() {
        hideProgress()
    }
    
    func showError(with title: String, message: String) {
        let action = UIAlertAction(title: "Okay".localized, style: .default)
        displayAlert(with: title, message: message, actions: [action])
    }
    
    func presentAlertToChangeLanguage() {
        let dismissAction = UIAlertAction(title: "Dismiss".localized, style: .cancel)
        let changeAction = UIAlertAction(
            title: "Continue".localized,
            style: .destructive
        ) { [weak self] _ in
            guard let self = self else { return }
            MOLH.setLanguageTo(self.currentLanguage == "en" ? "ar" : "en")
            MOLH.reset()
        }
        displayAlert(
            with: "Change Language".localized,
            message: "App will terminate to change the current language".localized,
            actions: [dismissAction, changeAction]
        )
    }
}

// MARK: - TableView Delegate & DataSource
extension HeadlinesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(indexPath: indexPath) as HeadlineCell
        presenter.cellConfiguration(cell, for: indexPath)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        presenter.willDisplayCell(at: indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter.didSelectItem(at: indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(
            style: .normal,
            title: "Add to favotite".localized
        ) { (_: UIContextualAction, _: UIView, success: (Bool) -> Void) in
            self.presenter.didSwipeToAddToFavorites(at: indexPath)
            success(true)
        }
        shareAction.image = UIImage(systemName: "bookmark")
        shareAction.backgroundColor = UIColor(named: "AppYellow")
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
}
