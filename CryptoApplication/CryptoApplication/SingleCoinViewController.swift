//
//  SingleCoinViewController.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//

import UIKit
class SingleCoinViewController: UIViewController{
    
    var logoImage = UIImageView()
    var amountUSDLabel = UILabel()
    var amountCoinAndChangeLabel = UILabel()
    var dayButton = UIButton()
    var weekButton = UIButton()
    var monthButton = UIButton()
    var yearButton = UIButton()
    var fiveYearButton = UIButton()
    var graphImage = UIImageView()
    weak var parentController: ViewController?
    weak var parentCoin: Coin?
    
    override func viewDidLoad() {
        title = parentCoin!.name
        view.backgroundColor = .white
        
        logoImage.image = parentCoin!.image
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)


        amountCoinAndChangeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        amountCoinAndChangeLabel.textColor = .lightGray
        amountCoinAndChangeLabel.text = "\(parentCoin!.getCurrencyForm(amount: parentCoin!.amountCoin))  \(parentCoin!.symbol)   \(parentCoin!.getRoundedPercentage(amount: parentCoin!.percentChnage))"
        amountCoinAndChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountCoinAndChangeLabel)
        
        amountUSDLabel.font = .systemFont(ofSize: 28, weight: .bold)
        amountUSDLabel.text = "$\(parentCoin!.getCurrencyForm(amount: parentCoin!.amountUSD))"
        amountUSDLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountUSDLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 75),
            logoImage.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            amountUSDLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 15),
            amountUSDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            amountCoinAndChangeLabel.topAnchor.constraint(equalTo: amountUSDLabel.bottomAnchor, constant: 10),
            amountCoinAndChangeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
}


