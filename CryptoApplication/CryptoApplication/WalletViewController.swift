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
    
    var testButton = UIButton()
    
    var alreadyLoaded = false
    var loadedPortfolioScreen: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wallet"
        view.backgroundColor = .white
        walletButton.setBackgroundImage(UIImage(named: "wallet2"), for: .normal)
        walletButton.backgroundColor = .white
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        
        portfolioButton.setBackgroundImage(UIImage(named: "portfolio1"), for: .normal)
        portfolioButton.backgroundColor = .white
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        portfolioButton.addTarget(self, action: #selector(portfolioButtonPress), for: .touchUpInside)
        view.addSubview(portfolioButton)
        
        newsButton.setBackgroundImage(UIImage(named:"news1"), for: .normal)
        newsButton.backgroundColor = .white
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        newsButton.addTarget(self, action: #selector(newsButtonPress), for: .touchUpInside)
        view.addSubview(newsButton)
        view.addSubview(newsButton)
        testButton.backgroundColor = .systemGray
        testButton.setTitle(" test ", for: .normal)
        testButton.setTitleColor(.white, for: .normal)
        testButton.layer.borderColor = UIColor.lightGray.cgColor
        testButton.layer.borderWidth = 0.5
        testButton.layer.cornerRadius = 15
        testButton.addTarget(self, action: #selector(testButtonPress), for: .touchUpInside)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testButton)
        
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
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func portfolioButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedPortfolioScreen!)
    }
    
    @objc func newsButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedPortfolioScreen!.loadedNewsScreen)
    }
    
    @objc func testButtonPress(){
        self.testButton.backgroundColor = .systemBlue
    }
}
