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
    var allButtons = [UIButton]()
    var graphImage = UIImageView()
    weak var parentController: ViewController?
    weak var parentCoin: Coin?
    
    override func viewDidLoad() {
        title = parentCoin!.name
        view.backgroundColor = .white
        
        allButtons = [dayButton, weekButton, monthButton, yearButton, fiveYearButton]
                
        logoImage.image = parentCoin!.logoImage
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
        
        dayButton.setTitle("  1D  ", for: .normal)
        dayButton.addTarget(self, action: #selector(buttonPress1), for: .touchUpInside)
        dayButton.setTitleColor(.darkGray, for: .normal)
        dayButton.backgroundColor = .white
        dayButton.layer.cornerRadius = 15
        dayButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dayButton)
        
        weekButton.setTitle("   1W   ", for: .normal)
        weekButton.addTarget(self, action: #selector(buttonPress2), for: .touchUpInside)
        weekButton.setTitleColor(.darkGray, for: .normal)
        weekButton.backgroundColor = .white
        weekButton.layer.cornerRadius = 15
        weekButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weekButton)
        
        monthButton.setTitle("   1M   ", for: .normal)
        monthButton.addTarget(self, action: #selector(buttonPress3), for: .touchUpInside)
        monthButton.setTitleColor(.darkGray, for: .normal)
        monthButton.backgroundColor = .white
        monthButton.layer.cornerRadius = 15
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(monthButton)
        
        yearButton.setTitle("   1Y   ", for: .normal)
        yearButton.addTarget(self, action: #selector(buttonPress4), for: .touchUpInside)
        yearButton.setTitleColor(.darkGray, for: .normal)
        yearButton.backgroundColor = .white
        yearButton.layer.cornerRadius = 15
        yearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yearButton)
        
        fiveYearButton.setTitle("   5Y   ", for: .normal)
        fiveYearButton.addTarget(self, action: #selector(buttonPress5), for: .touchUpInside)
        fiveYearButton.setTitleColor(.darkGray, for: .normal)
        fiveYearButton.backgroundColor = .white
        fiveYearButton.layer.cornerRadius = 15
        fiveYearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fiveYearButton)
        
        graphImage.contentMode = .scaleAspectFit
        graphImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graphImage)
        
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
        
        NSLayoutConstraint.activate([
            dayButton.topAnchor.constraint(equalTo: amountCoinAndChangeLabel.bottomAnchor, constant: 12),
            dayButton.trailingAnchor.constraint(equalTo: weekButton.leadingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            weekButton.topAnchor.constraint(equalTo: amountCoinAndChangeLabel.bottomAnchor, constant: 12),
            weekButton.trailingAnchor.constraint(equalTo: monthButton.leadingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            monthButton.topAnchor.constraint(equalTo: amountCoinAndChangeLabel.bottomAnchor, constant: 12),
            monthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            yearButton.topAnchor.constraint(equalTo: amountCoinAndChangeLabel.bottomAnchor, constant: 12),
            yearButton.leadingAnchor.constraint(equalTo: monthButton.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            fiveYearButton.topAnchor.constraint(equalTo: amountCoinAndChangeLabel.bottomAnchor, constant: 12),
            fiveYearButton.leadingAnchor.constraint(equalTo: yearButton.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            graphImage.topAnchor.constraint(equalTo: monthButton.bottomAnchor),
            graphImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            graphImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            graphImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            graphImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        buttonPress1()
    }
    
    func resetButtons(){
        for button in allButtons{
            button.backgroundColor = .white
        }
    }
    
    @objc func buttonPress1() {
        resetButtons()
        dayButton.backgroundColor = .lightGray
        graphImage.image = parentCoin!.dayImage
    }
    
    @objc func buttonPress2() {
        resetButtons()
        weekButton.backgroundColor = .lightGray
        graphImage.image = parentCoin!.weekImage
    }
    
    @objc func buttonPress3() {
        resetButtons()
        monthButton.backgroundColor = .lightGray
        graphImage.image = parentCoin!.monthImage
    }
    
    @objc func buttonPress4() {
        resetButtons()
        yearButton.backgroundColor = .lightGray
        graphImage.image = parentCoin!.yearImage
    }
    
    @objc func buttonPress5() {
        resetButtons()
        fiveYearButton.backgroundColor = .lightGray
        graphImage.image = parentCoin!.fiveYearImage
    }
}