//
//  Common.swift
//  MaticApp
//
//  Created by Manish Kumar on 29/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

struct Colors {
    static let blueLight = UIColor.init(red: 20/255, green: 94/255, blue: 244/255, alpha: 1)
    static let grayLight = UIColor.init(red: 235/255, green: 236/255, blue: 241/255, alpha: 1)
}

struct Spacing {
    static let standardSpacing = CGFloat(16)
    static let cornerRadius = CGFloat(4)
    static let currencyIconCornerRadius = CGFloat(25)
    static let previewImageCornerRadius = CGFloat(45)
}

struct Size {
    static let textFieldSize = CGSize(width: 250, height: 40)
    static let buttonSize = CGSize(width: 180, height: 40)
    static let currencyIconSize = CGSize(width: 50, height: 50)
    static let previewImageSize = CGSize(width: 80, height: 80)
}

struct Font {
    static let mediumFont = UIFont.systemFont(ofSize: 15)
    static let bigFont = UIFont.systemFont(ofSize: 17)
    static let smallFont = UIFont.systemFont(ofSize: 13)
    static let errorFont = UIFont.systemFont(ofSize: 12)
}

struct Strings {
    static let initVector = "abhz5st916zdf3f1"
}
