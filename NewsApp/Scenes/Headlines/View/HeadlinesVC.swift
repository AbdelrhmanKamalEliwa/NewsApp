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
}

// MARK: - Segmented Control Animation
extension HeadlinesVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.panGestureRecognizer.translation(in: self.view).y < 0 {
            segmentedControlBottomConstraint.constant = -100
            UIView.animate(withDuration: 0.5) { self.view.layoutIfNeeded() }
        } else {
            segmentedControlBottomConstraint.constant = 20
            UIView.animate(withDuration: 0.5) { self.view.layoutIfNeeded() }
        }
    }
}

// MARK: - SearchBar
extension HeadlinesVC: UISearchBarDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
}

// MARK: - Presenter Delegate
extension HeadlinesVC: HeadlinesViewProtocol {
    func setupSegmentedControll(with titles: [String]) {
        segmentedControl.setTitle(titles[0], forSegmentAt: 0)
        segmentedControl.setTitle(titles[1], forSegmentAt: 1)
        segmentedControl.setTitle(titles[2], forSegmentAt: 2)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    func setupNavbar() {
        setupCustomeNavbar(with: "Headlines")
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
        
    }
}
