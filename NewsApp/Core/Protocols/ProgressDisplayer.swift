//
//  ProgressDisplayer.swift
//  ViberTemplate
//
//  Created by Abdelrhman Eliwa on 04/05/2021.
//

import UIKit
import ProgressHUD

protocol ProgressDisplayerProtocol {
    func showProgress(backgroundColor: UIColor, spinnerColor: UIColor)
    func hideProgress()
}

extension ProgressDisplayerProtocol where Self: UIViewController {
    func showProgress(backgroundColor: UIColor = UIColor.gray, spinnerColor: UIColor = UIColor.white) {
        ProgressHUD.colorBackground = backgroundColor
        ProgressHUD.colorProgress = spinnerColor
        ProgressHUD.show()
        view.isUserInteractionEnabled = false
        navigationController?.view.isUserInteractionEnabled = false
    }
    
    func hideProgress() {
        ProgressHUD.dismiss()
        view.isUserInteractionEnabled = true
        navigationController?.view.isUserInteractionEnabled = true
    }
}
