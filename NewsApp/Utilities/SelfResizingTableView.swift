//
//  SelfResizingTableView.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 20/06/2021.
//

import UIKit

protocol SelfResizingTableViewProtocol: AnyObject {
    func contentSizeChanged(with contentSize: CGSize, for tableView: UITableView)
}

class SelfResizingTableView: UITableView {
    weak var selfResizingDelegate: SelfResizingTableViewProtocol?
    override func layoutSubviews() {
        super.layoutSubviews()
        selfResizingDelegate?.contentSizeChanged(with: self.contentSize, for: self)
    }
}
