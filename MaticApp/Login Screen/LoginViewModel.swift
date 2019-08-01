//
//  LoginViewModel.swift
//  MaticApp
//
//  Created by Manish Kumar on 01/08/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation

class LoginViewModel {
    public var username = ""
    public var password = ""
    
    public func authenticateUser() -> Bool {
        if let password = Keychain.load(key: username) {
            if password == self.password.data(using: .utf8)! {
                return true
            }
            return false
        }
        return false
    }
}
