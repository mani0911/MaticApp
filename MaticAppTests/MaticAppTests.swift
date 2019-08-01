//
//  MaticAppTests.swift
//  MaticAppTests
//
//  Created by Manish Kumar on 28/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import XCTest
@testable import MaticApp

class MaticAppTests: XCTestCase {
    var logInVM: LoginViewModel? = LoginViewModel()
    var signUpVM: SignUpViewModel? = SignUpViewModel()
    var homeVM: HomeViewModel? = HomeViewModel()
    var randomHash: String? = "70505812440997117919"
    var encryptHexString: String?  = "1fa7f8a28e967e665adfa77aa49ae03659040ec6984436332c43cf3a646925c9"
    
    override func setUp() {
        logInVM?.username = "Testing User"
        logInVM?.password = "12345678"
        signUpVM?.username = "Testing User"
        signUpVM?.password = "12345678"
        homeVM?.username = "Testing User"
        homeVM?.password = "12345678"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        logInVM = nil
        signUpVM = nil
        homeVM = nil
        randomHash = nil
        encryptHexString = nil
    }

    func testEncrypt() {
        guard let result = signUpVM?.encrypt(hash: randomHash!) else {return}
        let resultHexString = result.hexString
        XCTAssertEqual(resultHexString, encryptHexString)
    }

    func testAuthenticateUser() {
        let result = logInVM?.authenticateUser()
        XCTAssertTrue(result!)
    }
    
    func testDecypt() {
        let result = homeVM?.decrypt()
        XCTAssertEqual(result!, randomHash)
    }
}
