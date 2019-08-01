//
//  LoginViewController.swift
//  MaticApp
//
//  Created by Manish Kumar on 01/08/19.
//  Copyright © 2019 manish. All rights reserved.
//

import UIKit
import Anchorage

class LoginViewController: UIViewController {
    public let viewModel = LoginViewModel()
    private let loginView = UserInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(loginView)
        loginView.centerXAnchor == self.view.centerXAnchor
        loginView.centerYAnchor == self.view.centerYAnchor
        loginView.buttonTapped = {
            self.signIn()
        }
    }
    
    private func signIn() {
        guard let username = loginView.usernameTextField.text, !username.isEmpty
            else {
                loginView.errorLabel.isHidden = false
                loginView.errorLabel.text = "Username can't be left empty!"
                return
        }
        
        guard let password = loginView.passwordTextField.text, !password.isEmpty
            else {
                loginView.errorLabel.isHidden = false
                loginView.errorLabel.text = "Password can't be left empty!"
                return
        }
        
        self.viewModel.username = username
        self.viewModel.password = password
        
        self.viewModel.authenticateUser(completion: { [unowned self] (success, error) in
            if success {
            let vc = HomeViewController()
                vc.viewModel.username = username
                vc.viewModel.password = password
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.loginView.errorLabel.isHidden = false
                self.loginView.errorLabel.text = error!
            }
        })
    }
}
