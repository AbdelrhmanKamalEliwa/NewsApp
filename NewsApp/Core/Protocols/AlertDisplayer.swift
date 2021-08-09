//
//  AlertDisplayer.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 04/05/2021.
//

import UIKit

protocol AlertDisplayerProtocol {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertDisplayerProtocol where Self: UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}
