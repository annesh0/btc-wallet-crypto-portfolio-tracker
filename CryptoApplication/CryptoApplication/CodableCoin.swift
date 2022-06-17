//
//  CodableCoin.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/14/22.
//

import Foundation

struct codableCoin: Codable {
    var amountCoin: Double
    var isChosen: Bool
    init(amountCoin: Double, isChosen: Bool){
        self.amountCoin = amountCoin
        self.isChosen = isChosen
    }
}

struct codableCoins: Codable {
    var items: [codableCoin]
    
    init(){
        items = []
    }
}
