//
//  WalletViewController.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/17/22.
//

import Foundation
import UIKit

class WalletViewController: UIViewController {
    
    var walletButton = UIButton()
    var portfolioButton = UIButton()
    var newsButton = UIButton()
    
    var amountUSDLabel = UILabel()
    var amountBTCLabel = UILabel()
    var btcLabel = UILabel()
    
    var sendButton = UIButton()
    var receiveButton = UIButton()
    
    var alreadyLoaded = false
    var loadedPortfolioScreen: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 1)
        walletButton.setBackgroundImage(UIImage(named: "wallet3"), for: .normal)
        walletButton.backgroundColor = .clear
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        
        portfolioButton.setBackgroundImage(UIImage(named: "portfolio3"), for: .normal)
        portfolioButton.backgroundColor = .clear
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        portfolioButton.addTarget(self, action: #selector(portfolioButtonPress), for: .touchUpInside)
        view.addSubview(portfolioButton)
        
        newsButton.setBackgroundImage(UIImage(named:"news3"), for: .normal)
        newsButton.backgroundColor = .clear
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        newsButton.addTarget(self, action: #selector(newsButtonPress), for: .touchUpInside)
        view.addSubview(newsButton)
        view.addSubview(newsButton)
        
        var amountBTC = round(loadedPortfolioScreen!.allCoins[0].amountCoin * 1000000) / 1000000
        var amountUSD = loadedPortfolioScreen!.allCoins[0].amountUSD
        
        amountUSDLabel.text = "USD \(loadedPortfolioScreen!.getCurrencyForm(amount: amountUSD))"
        amountUSDLabel.textColor = UIColor(red: 190/255, green: 216/255, blue: 255/255, alpha: 1)
        amountUSDLabel.font = .systemFont(ofSize: 18, weight: .bold)
        amountUSDLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountUSDLabel)
        
        amountBTCLabel.text = String(amountBTC)
        amountBTCLabel.textColor = .white
        amountBTCLabel.font = .systemFont(ofSize: 40, weight: .bold)
        amountBTCLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountBTCLabel)
        
        btcLabel.text = "BTC"
        btcLabel.textColor = UIColor(red: 190/255, green: 216/255, blue: 255/255, alpha: 1)
        btcLabel.font = .systemFont(ofSize: 40, weight: .bold)
        btcLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btcLabel)
        
        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            walletButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            walletButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            walletButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            walletButton.widthAnchor.constraint(equalTo: portfolioButton.widthAnchor, multiplier: 4.0/3.0),
        ])
        
        NSLayoutConstraint.activate([
            portfolioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
            portfolioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            portfolioButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            portfolioButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
        
        NSLayoutConstraint.activate([
            newsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
            newsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newsButton.widthAnchor.constraint(equalTo: portfolioButton.widthAnchor, multiplier: 0.8),
            newsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05625),
        ])
        
        NSLayoutConstraint.activate([
            amountUSDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountUSDLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.35)
        ])
        
        NSLayoutConstraint.activate([
            amountBTCLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountBTCLabel.topAnchor.constraint(equalTo: amountUSDLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            btcLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btcLabel.topAnchor.constraint(equalTo: amountBTCLabel.bottomAnchor, constant: 10)
        ])
        
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    @objc func portfolioButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedPortfolioScreen!)
    }
    
    @objc func newsButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedPortfolioScreen!.loadedNewsScreen)
    }
    
}
