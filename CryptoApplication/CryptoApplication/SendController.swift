//
//  SendController.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 7/20/22.
//

import Foundation
import UIKit

class SendContoller: UIViewController {
    
    weak var parentController: WalletViewController?
    
    var amountBTC: Double? = 0.0
    var amountUSD: Double? = 0.0
    
    var exchangeRate: Double = 2.0
    
    var sendLabel = UILabel()
    
    var addressLabel = UILabel()
    var btcLabel = UILabel()
    var usdLabel = UILabel()
    
    var addressField = UITextField()
    var btcField = UITextField()
    var usdField = UITextField()
    
    var padding1 = UILabel()
    var padding2 = UILabel()
    var padding3 = UILabel()
    
    var sendButton = UIButton()
    var canSend = false
    var qrButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        sendLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        sendLabel.text = "Send"
        sendLabel.font = .systemFont(ofSize: 22, weight: .bold)
        sendLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendLabel)
        
        addressField.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        addressField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        addressField.font = .systemFont(ofSize: 18, weight: .bold)
        addressField.backgroundColor = .clear
        addressField.addTarget(self, action: #selector(checkButton), for: .editingChanged)
        addressField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressField)
        
        btcLabel.text = "BTC:"
        btcLabel.font = .systemFont(ofSize: 18, weight: .regular)
        btcLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        btcLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btcLabel)
        
        usdLabel.text = "USD:"
        usdLabel.font = .systemFont(ofSize: 18, weight: .regular)
        usdLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usdLabel)
        
        btcField.attributedPlaceholder = NSAttributedString(string: "0.0000", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        btcField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        btcField.font = .systemFont(ofSize: 18, weight: .bold)
        btcField.backgroundColor = .clear
        btcField.keyboardType = .decimalPad
        btcField.addTarget(self, action: #selector(btcUpdated), for: .editingChanged)
        btcField.addTarget(self, action: #selector(checkButton), for: .editingChanged)
        btcField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btcField)
        
        usdField.attributedPlaceholder = NSAttributedString(string: "00.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        usdField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        usdField.font = .systemFont(ofSize: 18, weight: .bold)
        usdField.backgroundColor = .clear
        usdField.keyboardType = .decimalPad
        usdField.addTarget(self, action: #selector(usdUpdated), for: .editingChanged)
        usdField.addTarget(self, action: #selector(checkButton), for: .editingChanged)
        usdField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usdField)
        
        padding1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        padding1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(padding1)
        
        padding2.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        padding2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(padding2)
        
        padding3.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        padding3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(padding3)
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = UIColor(red: 190/255, green: 216/255, blue: 255/255, alpha: 0.4)
        sendButton.layer.cornerRadius = 20
        sendButton.addTarget(self, action: #selector(sendButtonPress), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendButton)
        
        qrButton.setBackgroundImage(UIImage(named: "QR-Image"), for: .normal)
        qrButton.addTarget(self, action: #selector(qrButtonPress), for: .touchUpInside)
        qrButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qrButton)
        
        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            sendLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.02)
        ])
        
        NSLayoutConstraint.activate([
            addressField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1),
            addressField.trailingAnchor.constraint(equalTo: qrButton.leadingAnchor, constant: -4),
            addressField.topAnchor.constraint(equalTo: sendLabel.bottomAnchor, constant: view.frame.height * 0.03)
        ])
        
        NSLayoutConstraint.activate([
            qrButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width * 0.1),
            qrButton.topAnchor.constraint(equalTo: addressField.topAnchor),
            qrButton.bottomAnchor.constraint(equalTo: addressField.bottomAnchor),
//            qrButton.heightAnchor.constraint(equalTo: addressField.heightAnchor),
            qrButton.heightAnchor.constraint(equalToConstant: 28),
            qrButton.widthAnchor.constraint(equalTo: qrButton.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            btcLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1),
            btcLabel.topAnchor.constraint(equalTo: btcField.topAnchor),
            btcLabel.widthAnchor.constraint(equalToConstant: 58)
        ])
        
        NSLayoutConstraint.activate([
            btcField.leadingAnchor.constraint(equalTo: btcLabel.trailingAnchor),
            btcField.trailingAnchor.constraint(equalTo: addressField.trailingAnchor),
            btcField.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: view.frame.height * 0.06)
        ])
        
        NSLayoutConstraint.activate([
            usdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1),
            usdLabel.topAnchor.constraint(equalTo: usdField.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usdField.leadingAnchor.constraint(equalTo: btcField.leadingAnchor),
            usdField.trailingAnchor.constraint(equalTo: btcField.trailingAnchor),
            usdField.topAnchor.constraint(equalTo: btcField.bottomAnchor, constant: view.frame.height * 0.06)
        ])
        
        NSLayoutConstraint.activate([
            padding1.leadingAnchor.constraint(equalTo: addressField.leadingAnchor),
            padding1.trailingAnchor.constraint(equalTo: qrButton.trailingAnchor),
            padding1.bottomAnchor.constraint(equalTo: addressField.bottomAnchor, constant: view.frame.height * 0.01),
            padding1.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            padding2.leadingAnchor.constraint(equalTo: addressField.leadingAnchor),
            padding2.trailingAnchor.constraint(equalTo: qrButton.trailingAnchor),
            padding2.bottomAnchor.constraint(equalTo: btcField.bottomAnchor, constant: view.frame.height * 0.01),
            padding2.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            padding3.leadingAnchor.constraint(equalTo: addressField.leadingAnchor),
            padding3.trailingAnchor.constraint(equalTo: qrButton.trailingAnchor),
            padding3.bottomAnchor.constraint(equalTo: usdField.bottomAnchor, constant: view.frame.height * 0.01),
            padding3.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: addressField.leadingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: qrButton.trailingAnchor),
            sendButton.centerYAnchor.constraint(equalTo: padding3.bottomAnchor, constant: view.frame.height * 0.125),
            sendButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.0625)
        ])
    }
    
    func getCurrencyForm(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.currencySymbol = ""
        formatter.numberStyle = .currency
        return formatter.string(from: amount as NSNumber)!
    }
    
    @objc func sendButtonPress(){
        if canSend{
            
        }
    }
    
    @objc func qrButtonPress(){
        
    }
    
    @objc func btcUpdated(){
        if let text = btcField.text {
            if let amount = Double(text){
                amountBTC = amount
                amountUSD = amount * exchangeRate
                usdField.text = "\(getCurrencyForm(amount: amountUSD!))"
            }
            else{
                if btcField.text == "" {
                    amountUSD = 0
                    amountBTC = 0
                    usdField.text = ""
                }
                else if btcField.text == "." {
                    amountUSD = 0
                    amountBTC = 0
                    usdField.text = ""
                }
                else{
                    if amountBTC! > 0 {
                        btcField.text = "\(amountBTC!)"
                    }
                    else {
                        btcField.text = ""
                    }
                }
            }
        }
    }
    
    @objc func usdUpdated(){
        if let text = usdField.text {
            if let amount = Double(text){
                amountUSD = amount
                amountBTC = amount/exchangeRate
                btcField.text = "\(amountBTC!)"
            }
            else{
                if usdField.text == "" {
                    amountUSD = 0
                    amountBTC = 0
                    btcField.text = ""
                }
                else if usdField.text == "." {
                    amountUSD = 0
                    amountBTC = 0
                    btcField.text = ""
                }
                else {
                    if amountUSD! > 0 {
                        usdField.text = "\(getCurrencyForm(amount: amountUSD!))"
                    }
                    else{
                        usdField.text = ""
                    }
                }
            }
        }
    }
    
    @objc func checkButton(){
        if amountBTC! > 0 && amountUSD! > 0 && addressField.text != "" {
            sendButton.backgroundColor = UIColor(red: 190/255, green: 216/255, blue: 255/255, alpha: 1)
            canSend = true
        }
        else{
            sendButton.backgroundColor = UIColor(red: 190/255, green: 216/255, blue: 255/255, alpha: 0.4)
            canSend = false
        }
    }
    
}
