//
//  CurrencyCellView.swift
//  MaticApp
//
//  Created by Manish Kumar on 29/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

struct CurrencyDataModel: Codable {
    let name: String
    let symbol: String
    let value: String
}

class CurrencyTableViewCell: UITableViewCell {
    private let currencyNameLabel = UILabel()
    private let currencySymbolLabel = UILabel()
    private let currencyValueLabel = UILabel()
    private let currencyImageIcon = UIImageView()
    
    private let fetchImages = false
    
    public var index: Int?
    public var actionBlock: (() -> Void)? = nil

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    private func configureView() {
        backgroundColor = Colors.grayLight
        
        currencyImageIcon.layer.cornerRadius = Spacing.currencyIconCornerRadius
        currencyImageIcon.clipsToBounds = true
        addSubview(currencyImageIcon)
        currencyImageIcon.topAnchor == topAnchor + Spacing.standardSpacing
        currencyImageIcon.leadingAnchor == leadingAnchor + Spacing.standardSpacing
        currencyImageIcon.sizeAnchors == Size.currencyIconSize
        
        let currencyNameSymbolView = UIView()
        addSubview(currencyNameSymbolView)
        currencyNameSymbolView.leadingAnchor == currencyImageIcon.trailingAnchor + Spacing.standardSpacing
        
        currencyNameLabel.textColor = UIColor.black
        currencyNameLabel.font = Font.bigFont
        currencyNameLabel.text = "Currency"
        currencyNameSymbolView.addSubview(currencyNameLabel)
        currencyNameLabel.topAnchor == currencyNameSymbolView.topAnchor + Spacing.standardSpacing
        
        currencySymbolLabel.textColor = UIColor.black
        currencySymbolLabel.font = Font.smallFont
        currencySymbolLabel.text = "Symbol"
        currencyNameSymbolView.addSubview(currencySymbolLabel)
        currencySymbolLabel.topAnchor == currencyNameLabel.bottomAnchor + 8
        
        currencyValueLabel.textColor = UIColor.black
        currencyValueLabel.font = Font.smallFont
        currencyValueLabel.text = "100.0"
        currencyValueLabel.textAlignment = .right
        addSubview(currencyValueLabel)
        currencyValueLabel.topAnchor == topAnchor + Spacing.standardSpacing
        currencyValueLabel.trailingAnchor == trailingAnchor - Spacing.standardSpacing
        
        let gesture = UILongPressGestureRecognizer(target: self, action:  #selector(self.longPressed(sender:)))
        gesture.delegate = self as UIGestureRecognizerDelegate
        self.addGestureRecognizer(gesture)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        actionBlock?()
    }
    
    public func setData(currencyData: CurrencyDataModel) {
        currencyNameLabel.text = currencyData.name
        currencySymbolLabel.text = currencyData.symbol
        currencyValueLabel.text = currencyData.value
        if fetchImages {
            currencyImageIcon.image = nil 
            fetchImageAsync(index: index!)
        } else {
            currencyImageIcon.image = UIImage(named: currencyData.symbol.lowercased())
        }
    }
    
    public func fetchImageAsync(index: Int) {
        ImageFetcher.sharedInstance.fetchImagesInfo(for: index, completion: { imageURL, success, error in
            if success {
                if imageURL != nil {
                    ImageFetcher.sharedInstance.fetchImage(index: index, imageURL: imageURL!, completion: { (image, error) in
                        if let randomImage = image {
                            DispatchQueue.main.async {
                                self.currencyImageIcon.image = randomImage
                            }
                        }
                    })
                }
            }
        })
    }
}
