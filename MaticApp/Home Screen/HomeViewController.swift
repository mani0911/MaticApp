//
//  HomeViewController.swift
//  MaticApp
//
//  Created by Manish Kumar on 29/07/19.
//  Copyright © 2019 manish. All rights reserved.
//

import UIKit
import Anchorage

class HomeViewController: UIViewController {
    public let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.prepareTableData()
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = UIColor.white
        let showHashButton = UIButton()
        showHashButton.setTitle("Show Hash", for: .normal)
        showHashButton.backgroundColor = Colors.blueLight
        showHashButton.layer.cornerRadius = Spacing.cornerRadius
        showHashButton.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(showHashButton)
        showHashButton.centerXAnchor == self.view.centerXAnchor
        showHashButton.sizeAnchors == Size.buttonSize
        showHashButton.topAnchor == self.view.topAnchor + self.view.safeAreaInsets.top + 40
        showHashButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        
        let currencyTable = UITableView()
        currencyTable.delegate = self as? UITableViewDelegate
        currencyTable.dataSource = self as UITableViewDataSource
        currencyTable.rowHeight = 82
        currencyTable.sectionHeaderHeight = 50
        self.view.addSubview(currencyTable)
        currencyTable.leadingAnchor == self.view.leadingAnchor
        currencyTable.trailingAnchor == self.view.trailingAnchor
        currencyTable.topAnchor == showHashButton.bottomAnchor + 20
        currencyTable.bottomAnchor == self.view.bottomAnchor
        currencyTable.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "currencyCell")
    }
    
    @objc private func handleButtonTap() {
        let hash = viewModel.decrypt()
        let alertController = UIAlertController(title: "Hash", message: hash, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Tokens"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        cell.index = indexPath.row
        
        let currency = viewModel.currencyData[indexPath.row]
        cell.setData(currencyData: currency)
        cell.actionBlock = {
            self.longPressHandler(iconName: currency.symbol.lowercased())
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func longPressHandler(iconName: String) {
        let alertController = UIAlertController(title: "My Token", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default))
        let imageView = UIImageView()
        alertController.view.addSubview(imageView)
        imageView.topAnchor == alertController.view.topAnchor + 50
        imageView.centerXAnchor == alertController.view.centerXAnchor
        imageView.heightAnchor == 80
        imageView.widthAnchor == 80
        imageView.image = UIImage(named: iconName)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 180)
        alertController.view.addConstraint(height)
        self.present(alertController, animated: true, completion: nil)
    }
}
