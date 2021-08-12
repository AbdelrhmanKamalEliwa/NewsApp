//
//  FavoritesVC.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//

import UIKit

class FavoritesVC: BaseWireframe, CustomeNavbarProtocol {
    
    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    var presenter: FavoritesPresenterProtocol!
    
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

// MARK: - Presenter Delegate
extension FavoritesVC: FavoritesViewProtocol {
   
    func setupNavbar() {
        setupCustomeNavbar(with: "Favorites", largeTitle: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: HeadlineCell.self)
    }
    
    func fetchDataSuccess() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func deleteRowFromTableView(at indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func showError(with title: String, message: String) {
        let action = UIAlertAction(title: "Okay", style: .default)
        displayAlert(with: title, message: message, actions: [action])
    }
}

// MARK: - TableView Delegate & DataSource
extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
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
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        presenter.didSwipeToRemoveArticle(at: indexPath)
    }
}
