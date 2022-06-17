//
//  Coin.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//

import Foundation
import UIKit

class Coin {
    var name: String
    var symbol: String
    var logoImage: UIImage?
    var amountUSD: Double
    var amountCoin: Double
    var percentChnage: Double
    var conversionRate: Double
    var isChosen: Bool
    var savableCoin: codableCoin
    var dayImage: UIImage?
    var weekImage: UIImage?
    var monthImage: UIImage?
    var yearImage: UIImage?
    var fiveYearImage: UIImage?

    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
        self.logoImage = UIImage(named: name)
        self.conversionRate = 1.0
        self.amountUSD = 0.0
        self.amountCoin = 0.0
        self.percentChnage = 0.0
        self.isChosen = false
        self.savableCoin = codableCoin(amountCoin: amountCoin, isChosen: isChosen)
    }
    
    func getCurrencyForm(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.currencySymbol = ""
        formatter.numberStyle = .currency
        return formatter.string(from: amount as NSNumber)!
    }

    func getRoundedPercentage(amount: Double) -> String{
        return "\(round(amount * 10)/10.0)%"
    }
    
    func updateSavableCoin(){
        self.savableCoin.amountCoin = self.amountCoin
        self.savableCoin.isChosen = self.isChosen
    }
    
    func getSavedData(){
        self.amountCoin =  self.savableCoin.amountCoin
        self.isChosen = self.savableCoin.isChosen
        self.amountUSD = self.amountCoin * self.conversionRate
    }
}
