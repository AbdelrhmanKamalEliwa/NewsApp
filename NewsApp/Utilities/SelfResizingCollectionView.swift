//
//  SelfResizingCollectionView.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 08/07/2021.
//

import UIKit

protocol SelfResizingCollectionViewProtocol: AnyObject {
    func contentSizeChanged(with contentSize: CGSize, for collectionView: UICollectionView)
}

class SelfResizingCollectionView: UICollectionView {
    weak var selfResizingDelegate: SelfResizingCollectionViewProtocol?
    override func layoutSubviews() {
        super.layoutSubviews()
        selfResizingDelegate?.contentSizeChanged(with: self.contentSize, for: self)
    }
}
