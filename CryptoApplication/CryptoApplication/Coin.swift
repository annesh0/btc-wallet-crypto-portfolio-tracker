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
    var logoImage: UIImage
    var amountUSD = 0.0
    var amountCoin = 0.0
    var percentChnage = 0.0
    var conversionRate = 1.0
    var isChosen: Bool
    var dayImage: UIImage?
    var weekImage: UIImage?
    var monthImage: UIImage?
    var yearImage: UIImage?
    var fiveYearImage: UIImage?

    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
        self.logoImage = UIImage(named: name)!
        isChosen = false
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
}
