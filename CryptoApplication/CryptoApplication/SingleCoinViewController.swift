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
    var weekButton = UIButton()
    var monthButton = UIButton()
    var yearButton = UIButton()
    var allButtons = [UIButton]()
    let gradient = CAGradientLayer()
    let weeklyChild = UIHostingController(rootView: WeeklyContentView())
    let monthlyChild = UIHostingController(rootView: MonthlyContentView())
    let yearlyChild = UIHostingController(rootView: YearlyContentView())
    weak var parentController: ViewController?
    weak var parentCoin: Coin?
    //var child = UIHostingController(rootView: ContentView())
    
    override func viewDidLoad() {
        title = parentCoin!.name
        view.backgroundColor = .white
        
        let gradientColor = parentCoin!.mainColor.cgColor
        gradientColor.copy(alpha: 0.5)
        gradient.frame = CGRect(x:0, y:0, width: view.frame.width, height: 200)
        gradient.colors = [gradientColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        allButtons = [weekButton, monthButton, yearButton]
                
        logoImage.image = parentCoin!.logoImage
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)

        amountCoinAndChangeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        amountCoinAndChangeLabel.textColor = .lightGray
        amountCoinAndChangeLabel.text = "\(parentCoin!.getCurrencyForm(amount: parentCoin!.amountCoin))  \(parentCoin!.symbol)   \(parentCoin!.getRoundedPercentage(amount: parentCoin!.percentChnage))"
        amountCoinAndChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountCoinAndChangeLabel)
        
        amountUSDLabel.font = .systemFont(ofSize: 35, weight: .bold)
        amountUSDLabel.text = "$\(parentCoin!.getCurrencyForm(amount:parentCoin!.amountUSD))"
        amountUSDLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountUSDLabel)
        
        weekButton.setTitle("   1W   ", for: .normal)
        weekButton.addTarget(self, action: #selector(buttonPress1), for: .touchUpInside)
        weekButton.setTitleColor(.darkGray, for: .normal)
        weekButton.backgroundColor = .white
        weekButton.layer.cornerRadius = 15
        weekButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weekButton)
        
        monthButton.setTitle("   1M   ", for: .normal)
        monthButton.addTarget(self, action: #selector(buttonPress2), for: .touchUpInside)
        monthButton.setTitleColor(.darkGray, for: .normal)
        monthButton.backgroundColor = .white
        monthButton.layer.cornerRadius = 15
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(monthButton)
        
        yearButton.setTitle("   1Y   ", for: .normal)
        yearButton.addTarget(self, action: #selector(buttonPress3), for: .touchUpInside)
        yearButton.setTitleColor(.darkGray, for: .normal)
        yearButton.backgroundColor = .white
        yearButton.layer.cornerRadius = 15
        yearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yearButton)
        
        //getWeeklyData()
        //getMonthlyData()
        //getYearlyData()
        
        setupConstraints()
    }
    
    struct WeeklyContentView : View {
        var body: some View {
            VStack {
                let prices = SingleCoinViewController.weeklyPrices
                LineChartView(lineChartController: LineChartController(prices: prices, dragGesture: true))
                    .frame(width: 300)
            }
        }
    }
    
    struct MonthlyContentView : View {
        var body: some View {
            VStack {
                let prices = SingleCoinViewController.monthlyPrices
                LineChartView(lineChartController: LineChartController(prices: prices, dragGesture: true))
                    .frame(width: 300)
            }
        }
    }
    
    struct YearlyContentView : View {
        var body: some View {
            VStack {
                let prices = SingleCoinViewController.yearlyPrices
                LineChartView(lineChartController: LineChartController(prices: prices, dragGesture: true))
                    .frame(width: 300)
            }
        }
    }
    
    static var weeklyPrices: [Double] = []
    func getWeeklyData() {
        SingleCoinViewController.weeklyPrices = []
        NetworkManager.getCoinWeeklyData(completion: { (data,error) in
            var allData: [[String:Any]] = []
            allData = data as! [[String:Any]]
            for entry in allData {
                SingleCoinViewController.weeklyPrices.append(entry["rate_open"]! as! Double)
            }
            self.weeklyChild.view.translatesAutoresizingMaskIntoConstraints = false
            self.weeklyChild.view.frame = self.view.bounds
        }, internalAssetID: parentCoin!.internalAssetID)
    }
    
    static var monthlyPrices: [Double] = []
    func getMonthlyData() {
        SingleCoinViewController.monthlyPrices = []
        NetworkManager.getCoinMonthlyData(completion: { (data,error) in
            //print(data!)
            //print(a["asset_id_base"]!)
            //var prices: [Double] = []
            var allData: [[String:Any]] = []
            allData = data as! [[String:Any]]
            for entry in allData {
                SingleCoinViewController.monthlyPrices.append(entry["rate_open"]! as! Double)
            }
            self.monthlyChild.view.translatesAutoresizingMaskIntoConstraints = false
            self.monthlyChild.view.frame = self.view.bounds
            self.view.addSubview(self.monthlyChild.view)
            NSLayoutConstraint.activate([
                self.monthlyChild.view.topAnchor.constraint(equalTo: self.monthButton.bottomAnchor, constant: 12),
                self.monthlyChild.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.monthlyChild.view.heightAnchor.constraint(equalToConstant: 200)
            ])
            self.buttonPress2()
        }, internalAssetID: parentCoin!.internalAssetID)
    }
    
    static var yearlyPrices: [Double] = []
    func getYearlyData() {
        SingleCoinViewController.yearlyPrices = []
        NetworkManager.getCoinYearlyData(completion: { (data,error) in
            var allData: [[String:Any]] = []
            allData = data as! [[String:Any]]
            for entry in allData {
                SingleCoinViewController.yearlyPrices.append(entry["rate_open"]! as! Double)
            }
            self.yearlyChild.view.translatesAutoresizingMaskIntoConstraints = false
            self.yearlyChild.view.frame = self.view.bounds
        }, internalAssetID: parentCoin!.internalAssetID)
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
    }
    
    func resetButtons(){
        for button in allButtons{
            button.backgroundColor = .clear
            button.setTitleColor(.darkGray, for: .normal)
        }
        weeklyChild.view.removeFromSuperview()
        monthlyChild.view.removeFromSuperview()
        yearlyChild.view.removeFromSuperview()
    }
    
    @objc func buttonPress1() {
        resetButtons()
        weekButton.setTitleColor(.white, for: .normal)
        weekButton.backgroundColor = parentCoin!.mainColor
        view.addSubview(weeklyChild.view)
        NSLayoutConstraint.activate([
            weeklyChild.view.topAnchor.constraint(equalTo: self.monthButton.bottomAnchor, constant: 12),
            weeklyChild.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weeklyChild.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func buttonPress2() {
        resetButtons()
        monthButton.setTitleColor(.white, for: .normal)
        monthButton.backgroundColor = parentCoin!.mainColor
        view.addSubview(monthlyChild.view)
        NSLayoutConstraint.activate([
            monthlyChild.view.topAnchor.constraint(equalTo: self.monthButton.bottomAnchor, constant: 12),
            monthlyChild.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            monthlyChild.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func buttonPress3() {
        resetButtons()
        yearButton.setTitleColor(.white, for: .normal)
        yearButton.backgroundColor = parentCoin!.mainColor
        view.addSubview(yearlyChild.view)
        NSLayoutConstraint.activate([
            yearlyChild.view.topAnchor.constraint(equalTo: self.monthButton.bottomAnchor, constant: 12),
            yearlyChild.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            yearlyChild.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
