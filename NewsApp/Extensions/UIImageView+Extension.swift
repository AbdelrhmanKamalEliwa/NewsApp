//
//  UIImageView+Extension.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 07/06/2021.
//

import Kingfisher

extension UIImageView {
    func setImageUrl(_ imageUrl: String?) {
        if let imageUrl = imageUrl {
            guard let url = URL(string: imageUrl) else {
                self.image = UIImage(named: "not.found")?
                    .imageFlippedForRightToLeftLayoutDirection()
                return
            }
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url, placeholder: nil, options: nil,
                progressBlock: nil) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.self.image = image.image
                case .failure:
                    self.self.image = UIImage(named: "not.found")?
                        .imageFlippedForRightToLeftLayoutDirection()
                    return
                }
            }
        } else {
            self.self.image = UIImage(named: "not.found")?
                .imageFlippedForRightToLeftLayoutDirection()
        }
    }
}
