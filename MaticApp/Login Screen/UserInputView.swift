//
//  SelectActionView.swift
//  MaticApp
//
//  Created by Manish Kumar on 28/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

class UserInputView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var buttonTapped: (() -> Void)? = nil
    public let usernameTextField = UITextField()
    public let passwordTextField = UITextField()
    public let actionButton = UIButton()
    public let errorLabel = UILabel()
    
    public func configureView() {
        usernameTextField.font = Font.mediumFont
        usernameTextField.placeholder = "username"
        usernameTextField.textColor = UIColor.black
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.isEnabled = true
        usernameTextField.clearButtonMode = .always
        self.addSubview(usernameTextField)
        usernameTextField.sizeAnchors == Size.textFieldSize
        usernameTextField.leadingAnchor == self.leadingAnchor
        usernameTextField.trailingAnchor == self.trailingAnchor
        usernameTextField.topAnchor == self.topAnchor
        
        passwordTextField.placeholder = "password"
        passwordTextField.textColor = UIColor.black
        passwordTextField.font = Font.mediumFont
        passwordTextField.isUserInteractionEnabled = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clearButtonMode = .always
        self.addSubview(passwordTextField)
        passwordTextField.sizeAnchors == Size.textFieldSize
        passwordTextField.centerXAnchor == self.centerXAnchor
        passwordTextField.topAnchor == usernameTextField.bottomAnchor + 30
        
        errorLabel.font = Font.errorFont
        errorLabel.textColor = UIColor.red
        self.addSubview(errorLabel)
        errorLabel.topAnchor == passwordTextField.bottomAnchor + 20
        errorLabel.centerXAnchor == self.centerXAnchor
        errorLabel.isHidden = false
        
        actionButton.setTitle("Sign In", for: .normal)
        actionButton.backgroundColor = Colors.blueLight
        actionButton.layer.cornerRadius = Spacing.cornerRadius
        actionButton.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(actionButton)
        actionButton.sizeAnchors == Size.buttonSize
        actionButton.topAnchor == passwordTextField.bottomAnchor + 60
        actionButton.centerXAnchor == self.centerXAnchor
        actionButton.bottomAnchor == self.bottomAnchor
        actionButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        
    }
    
    @objc private func handleButtonTap() {
        self.buttonTapped?()
    }
}
