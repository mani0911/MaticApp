//
//  HomeViewModel.swift
//  MaticApp
//
//  Created by Manish Kumar on 29/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation

class HomeViewModel {
    public var username = ""
    public var password = ""
    public var currencyData = [CurrencyDataModel]()
    
    public func decrypt() -> String {
        do {
            if let receivedData = Keychain.load(key: "\(username)-hash") {
                let iv = Strings.initVector.data(using: .utf8)!
                let key = try AES256.createKey(password: password.data(using: .utf8)!, salt: self.username.data(using: .utf8)!)
                let aes = try AES256(key: key, iv: iv)
                let decrypted = try aes.decrypt(receivedData)
                let hash = String(decoding: decrypted, as: UTF8.self)
                return hash
            }
            return "hash fetching failed!!"
        } catch {
            return "\(error.localizedDescription)"
        }
    }
    
    public func prepareTableData() {
        currencyData.append(CurrencyDataModel(name: "PACcoin", symbol: "$PAC", value: "100.4"))
        currencyData.append(CurrencyDataModel(name: "0xBitcoin", symbol: "0XBTC", value: "20.4"))
        currencyData.append(CurrencyDataModel(name: "2Give", symbol: "2GIVE", value: "90.0"))
        currencyData.append(CurrencyDataModel(name: "Arcblock", symbol: "ABT", value: "81.6"))
        currencyData.append(CurrencyDataModel(name: "Achain", symbol: "ACT", value: "73.3"))
        currencyData += currencyData
        currencyData += currencyData
    }
}
