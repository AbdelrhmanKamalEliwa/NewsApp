//
//  OnboardingVC.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 09/08/2021.
//

import UIKit
import SKCountryPicker

class OnboardingVC: BaseWireframe, DefaultNavbarProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countryTitleLabel: UILabel!
    @IBOutlet private weak var contryPickerView: CountryPickerView!
    @IBOutlet private weak var categoriesTitleLabel: UILabel!
    @IBOutlet private var categoriesButtons: [UIButton]!
    @IBOutlet private var categoriesTitles: [UILabel]!
    @IBOutlet private weak var startButton: UIButton!
    var presenter: OnBoardingPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.viewDidLayoutSubViews()
    }
    
    @IBAction private func didTapCategoriesButtons(_ sender: UIButton) {
        presenter.didTapCategoriesButtons(for: sender.tag, with: sender.accessibilityIdentifier)
    }
    
    @IBAction private func didTapStartButton(_ sender: UIButton) {
        presenter.didTapStartButton()
    }
    
    private func listenToPickerView() {
        contryPickerView.onSelectCountry { [weak self] country in
            guard let self = self else { return }
            self.presenter.didSelectCountry(with: country.countryCode)
        }
    }
}

// MARK: - Presenter Delegate
extension OnboardingVC: OnBoardingViewProtocol {
   
    func setupUI() {
        listenToPickerView()
        startButton.cornerRadius = startButton.frame.height / 6
    }
    
    func setLocalizedStrings() {
        titleLabel.text = "OnboardingVC.titleLabel".localized
        countryTitleLabel.text = "OnboardingVC.countryTitleLabel".localized
        categoriesTitleLabel.text = "OnboardingVC.categoriesTitleLabel".localized
        categoriesTitles.forEach({$0.text = Categories.getTitle(for: $0.tag).localized})
        startButton.setTitle("OnboardingVC.startButton".localized, for: .normal)
    }
    
    func setupNavbar() {
        setupNavbarDefaultUI()
    }
    
    func updateCategoriesButtonsUI(
        for buttonIndex: Int,
        accessibilityIdentifier identifier: String,
        imageName name: String
    ) {
        categoriesButtons[buttonIndex].setImage(UIImage(systemName: name), for: .normal)
        categoriesButtons[buttonIndex].accessibilityIdentifier = identifier
    }
    
    func showError(with title: String, message: String) {
        let action = UIAlertAction(title: "Okay".localized, style: .default)
        displayAlert(with: title, message: message, actions: [action])
    }
}
