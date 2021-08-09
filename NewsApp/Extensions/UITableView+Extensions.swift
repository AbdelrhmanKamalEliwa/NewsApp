//
//  UITableView+Extensions.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(
            UINib(nibName: String(describing: Cell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: Cell.self))
    }

    func dequeue<Cell: UITableViewCell>(indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard
            let cell = self.dequeueReusableCell(
                withIdentifier: identifier,
                for: indexPath) as? Cell
        else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerHeaderFooter<Header: UITableViewHeaderFooterView>(cellClass: Header.Type) {
        // MARK: Generic Register Header (Header/Footer)
        self.register(UINib(nibName: String(describing: Header.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: Header.self))
    }

    //    UICollectionView.elementKindSectionHeader

    func dequeueHeaderFooter<Header: UITableViewHeaderFooterView>() -> Header {
        let identifier = String(describing: Header.self)
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header else {
            fatalError("Error in cell")
        }
        return header
    }
}
