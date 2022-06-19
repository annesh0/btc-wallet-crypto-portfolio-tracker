//
//  SingleCoinViewController.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//

import UIKit
import Foundation
import StockCharts
import SwiftUI

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
        amountUSDLabel.text = "$\(parentCoin!.getCurrencyForm(amount:parentCoin!.amountUSD))"
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
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = view.bounds
        view.addSubview(child.view)
        //view.addSubview(graphImage)
        
        
        
        setupConstraints()
    }
    
    struct ContentView : View {
        var body: some View {
            LineChartView(lineChartController: LineChartController(prices: SingleCoinViewController.getMonthlyData()))
            .frame(width: 150)
            VStack {
                Text("Test")
                Text("Test2")

            }
        }
    }
    
    static func getMonthlyData() -> [Double] {
        var prices: [Double] = []
        NetworkManager.getMonthlyBTCPrice { (data,error) in
            //print(data!)
            //print(a["asset_id_base"]!)
            //var prices: [Double] = []
            var allData: [[String:Any]] = []
            allData = data as! [[String:Any]]
            for entry in allData {
                prices.append(entry["rate_open"]! as! Double)
            }
            DispatchQueue.main.async {
                
            }
        }
        return prices
    }

    var child = UIHostingController(rootView: ContentView())
    
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
    }
    
    @objc func buttonPress2() {
        resetButtons()
        weekButton.backgroundColor = .lightGray
    }
    
    @objc func buttonPress3() {
        resetButtons()
        monthButton.backgroundColor = .lightGray
    }
    
    @objc func buttonPress4() {
        resetButtons()
        yearButton.backgroundColor = .lightGray
    }
    
    @objc func buttonPress5() {
        resetButtons()
        fiveYearButton.backgroundColor = .lightGray
    }
}
