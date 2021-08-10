//
//  HeadlineCell.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import UIKit

class HeadlineCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet private weak var headlineImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

// MARK: - HeadlineCellProtocol Delegate
extension HeadlineCell: HeadlineCellProtocol {
    func configure(model: ArticleModel) {
        headlineImageView.setImageUrl(model.urlToImage)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        sourceLabel.text = model.source.name
        dateLabel.text = model.publishedAt
    }
}
