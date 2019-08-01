//
//  Keychain.swift
//  MaticApp
//
//  Created by Manish Kumar on 30/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation

class Keychain {
    class func save(key: String, value: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : value ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
