//
//  assets.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 5/31/22.
//

import Foundation

var allAssets: [Int:String] = [:] // Lists all asset names mapped to key

var heldAssets: [Int:Int] = [:] //Maps key of asset to amount of asset held


class Asset {
    var name: String
    var amount: Int?
    
    init(name:String, amount:Int?) {
        self.name = name
        self.amount = amount
    }
}
