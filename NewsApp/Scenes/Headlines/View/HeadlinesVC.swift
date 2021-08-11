//
//  HeadlinesVC.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import UIKit

class HeadlinesVC: BaseWireframe, CustomeNavbarProtocol {
    
    // MARK: - Properties
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var segmentedControlBottomConstraint: NSLayoutConstraint!
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
    
    @IBAction private func didTapSegmentedControl(_ sender: UISegmentedControl) {
        presenter.didTapSegmentedControl(for: segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex))
    }
    
    @objc
    private func didTapLocalizationButton() {
        
    }
    
    @objc
    private func didTapFavoritesButton() {
        
    }
}

// MARK: - Scrolling Animation
extension HeadlinesVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.panGestureRecognizer.translation(in: self.view).y < 0 {
            searchBar.isHidden = true
            tableViewTopConstraint.constant = 0
            segmentedControlBottomConstraint.constant = -100
            UIView.animate(withDuration: 0.5) { self.view.layoutIfNeeded() }
        } else {
            searchBar.isHidden = false
            tableViewTopConstraint.constant = 60
            segmentedControlBottomConstraint.constant = 20
            UIView.animate(withDuration: 0.5) { self.view.layoutIfNeeded() }
        }
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
    
    func setupSegmentedControll(with titles: [String]) {
        segmentedControl.setTitle(titles[0].capitalizingFirstLetter(), forSegmentAt: 0)
        segmentedControl.setTitle(titles[1].capitalizingFirstLetter(), forSegmentAt: 1)
        segmentedControl.setTitle(titles[2].capitalizingFirstLetter(), forSegmentAt: 2)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    func setupNavbar() {
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(
            title: "AR",
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
            with: "Headlines",
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
        let action = UIAlertAction(title: "Okay", style: .default)
        displayAlert(with: title, message: message, actions: [action])
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
            title: "Add to favotite"
        ) { (_: UIContextualAction, _: UIView, success: (Bool) -> Void) in
            
            success(true)
        }
        shareAction.image = UIImage(systemName: "bookmark")
        shareAction.backgroundColor = UIColor(named: "AppYellow")
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
}
