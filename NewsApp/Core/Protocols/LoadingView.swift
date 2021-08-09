//
//  LoadingView.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 04/06/2021.
//

import UIKit
import Lottie

protocol LoadingViewProtocol {
    func showLoadingView(animationView: AnimationView, topViews: [UIView])
    func hideLoadingView(animationView: AnimationView, topViews: [UIView])
}

extension LoadingViewProtocol where Self: UIViewController {
    
    func showLoadingView(animationView: AnimationView, topViews: [UIView]) {
        topViews.forEach({$0.isHidden = true})
        animationView.isHidden = false
        animationView.loopMode = .loop
        animationView.play()
        view.isUserInteractionEnabled = false
        navigationController?.view.isUserInteractionEnabled = false
    }
    
    func hideLoadingView(animationView: AnimationView, topViews: [UIView]) {
        topViews.forEach({$0.isHidden = false})
        animationView.isHidden = true
        animationView.stop()
        view.isUserInteractionEnabled = true
        navigationController?.view.isUserInteractionEnabled = true
    }
}
