//
//  FavoritesRouter.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//

import UIKit
import SafariServices

class FavoritesRouter: FavoritesRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = FavoritesVC()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func presentSafariVC(form view: FavoritesViewProtocol?, with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        if let viewController = view as? UIViewController {
            viewController.present(safariVC, animated: true, completion: nil)
        }
    }
}
