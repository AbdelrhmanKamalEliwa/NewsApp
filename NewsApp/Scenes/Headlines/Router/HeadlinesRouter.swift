//
//  HeadlinesRouter.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import UIKit
import SafariServices

class HeadlinesRouter: HeadlinesRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(countryCode: String, categories: [Categories]) -> UIViewController {
        let view = HeadlinesVC()
        let interactor = HeadlinesInteractor()
        let router = HeadlinesRouter()
        let presenter = HeadlinesPresenter(
            view: view,
            interactor: interactor,
            router: router,
            countryCode: countryCode,
            categories: categories
        )
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func presentSafariVC(form view: HeadlinesViewProtocol?, with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        if let viewController = view as? UIViewController {
            viewController.present(safariVC, animated: true, completion: nil)
        }
    }
    
    func presentFavoritesVC(from view: HeadlinesViewProtocol?) {
        let favoritesVC = FavoritesRouter.createModule()
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(favoritesVC, animated: true)
        }
    }
}
