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
    
    public func authenticateUser(completion:@escaping (Bool, String?) -> ()) {
        if let password = Keychain.load(key: username) {
            if password == self.password.data(using: .utf8)! {
                completion(true, nil)
            } else {
                completion(false, "wrong password!")
            }
        } else {
            completion(false, "username does not exists!")
        }
    }
}
