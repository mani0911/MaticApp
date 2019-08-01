//
//  SignUpViewModel.swift
//  MaticApp
//
//  Created by Manish Kumar on 01/08/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation
import CommonCrypto

class SignUpViewModel {
    public var username = ""
    public var password = ""
    
    public func encrypt(hash: String) -> Data? {
        do {
            let iv = Strings.initVector.data(using: .utf8)!
            let key = try AES256.createKey(password: password.data(using: .utf8)!, salt: username.data(using: .utf8)!)
            let aes = try AES256(key: key, iv: iv)
            let encrypted = try aes.encrypt(hash.data(using: .utf8)!)
            return encrypted
        } catch {
            return nil
        }
    }
    
    public func createAccount() -> Bool {
        let hash = generateRandomDigits(length: 20)
        if let encrypted = encrypt(hash: hash) {
            saveToKeyChain(hash: encrypted)
            return true
        }
        return false
    }
    
    private func saveToKeyChain(hash: Data) {
        let _ = Keychain.save(key: "\(username)-hash", value: hash)
        let _ = Keychain.save(key: username, value: password.data(using: .utf8)!)
    }
    
    private func generateRandomDigits(length: Int) -> String {
        var number = ""
        for i in 0..<length {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
}
