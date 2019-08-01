//
//  LandingViewController.swift
//  MaticApp
//
//  Created by Manish Kumar on 28/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import UIKit
import Anchorage

class LandingViewController: UIViewController {
    private let selectActionView = UIView()
    private let signInViewButton = UIButton()
    private let createAccountViewButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(selectActionView)
        selectActionView.centerYAnchor == self.view.centerYAnchor
        selectActionView.centerXAnchor == self.view.centerXAnchor
        
        signInViewButton.setTitle("Sign In", for: .normal)
        signInViewButton.layer.borderColor = Colors.blueLight.cgColor
        signInViewButton.layer.borderWidth = 1
        signInViewButton.layer.cornerRadius = Spacing.cornerRadius
        signInViewButton.setTitleColor(Colors.blueLight, for: .normal)
        selectActionView.addSubview(signInViewButton)
        signInViewButton.sizeAnchors == Size.buttonSize
        signInViewButton.topAnchor == selectActionView.topAnchor
        signInViewButton.leadingAnchor == selectActionView.leadingAnchor
        signInViewButton.trailingAnchor == selectActionView.trailingAnchor
        signInViewButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        createAccountViewButton.setTitle("Create Account", for: .normal)
        createAccountViewButton.backgroundColor = Colors.blueLight
        createAccountViewButton.layer.cornerRadius = Spacing.cornerRadius
        createAccountViewButton.setTitleColor(UIColor.white, for: .normal)
        selectActionView.addSubview(createAccountViewButton)
        createAccountViewButton.sizeAnchors == Size.buttonSize
        createAccountViewButton.topAnchor == signInViewButton.bottomAnchor + 20
        createAccountViewButton.leadingAnchor == selectActionView.leadingAnchor
        createAccountViewButton.trailingAnchor == selectActionView.trailingAnchor
        createAccountViewButton.bottomAnchor == selectActionView.bottomAnchor
        createAccountViewButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signInButtonTapped() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func createButtonTapped() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}

