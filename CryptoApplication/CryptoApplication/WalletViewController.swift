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
    var borderBuffer = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wallet"
        view.backgroundColor = .white
        walletButton.backgroundColor = .lightGray
        walletButton.layer.borderColor = UIColor.lightGray.cgColor
        walletButton.layer.borderWidth = 0.5
        walletButton.layer.cornerRadius = 0
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        portfolioButton.backgroundColor = .white
        portfolioButton.layer.borderColor = UIColor.lightGray.cgColor
        portfolioButton.layer.borderWidth = 0.5
        portfolioButton.layer.cornerRadius = 0
        portfolioButton.addTarget(self, action: #selector(portfolioButtonPress), for: .touchUpInside)
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portfolioButton)
        newsButton.backgroundColor = .white
        newsButton.layer.borderColor = UIColor.lightGray.cgColor
        newsButton.layer.borderWidth = 0.5
        newsButton.layer.cornerRadius = 0
        newsButton.addTarget(self, action: #selector(newsButtonPress), for: .touchUpInside)
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsButton)
        borderBuffer.isEditable = false
        borderBuffer.isSelectable = false
        borderBuffer.isScrollEnabled = false
        borderBuffer.backgroundColor = .lightGray
        borderBuffer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(borderBuffer)
        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            walletButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            walletButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            walletButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            walletButton.trailingAnchor.constraint(equalTo: portfolioButton.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            portfolioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            portfolioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            portfolioButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            portfolioButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0/3.0)
        ])
        
        NSLayoutConstraint.activate([
            newsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            newsButton.leadingAnchor.constraint(equalTo: portfolioButton.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            borderBuffer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderBuffer.bottomAnchor.constraint(equalTo: portfolioButton.topAnchor),
            borderBuffer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderBuffer.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    @objc func portfolioButtonPress(){
        let root = ViewController()
        self.view.window?.rootViewController = UINavigationController(rootViewController: root)
    }
    
    @objc func newsButtonPress(){
        let root = NewsViewController()
        self.view.window?.rootViewController = UINavigationController(rootViewController: root)
    }

}
