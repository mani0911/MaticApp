//
//  SignUpViewController.swift
//  MaticApp
//
//  Created by Manish Kumar on 01/08/19.
//  Copyright © 2019 manish. All rights reserved.
//

import UIKit
import Anchorage

class SignUpViewController: UIViewController {
    public let viewModel = SignUpViewModel()
    private let loginView = UserInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(loginView)
        loginView.centerAnchors == self.view.centerAnchors
        loginView.actionButton.setTitle("Create Account", for: .normal)
        loginView.buttonTapped = {
            self.createAccount()
        }
    }

    private func createAccount() {
        guard let username = loginView.usernameTextField.text, !username.isEmpty
            else {
                loginView.errorLabel.isHidden = false
                loginView.errorLabel.text = "username can't be left empty"
                return
        }
        guard let password = loginView.passwordTextField.text, !password.isEmpty
            else {
                loginView.errorLabel.isHidden = false
                loginView.errorLabel.text = "password can't be left empty"
                return
        }
        self.viewModel.username = username
        self.viewModel.password = password
        let accountCreated = self.viewModel.createAccount()
        if accountCreated {
            let vc = HomeViewController()
            vc.viewModel.username = self.viewModel.username
            vc.viewModel.password = self.viewModel.password
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            loginView.errorLabel.isHidden = false
            loginView.errorLabel.text = "account creation failed!"
        }
    }
}
