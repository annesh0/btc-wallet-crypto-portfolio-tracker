//
//  Json.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 6/9/22.
//
import Foundation

struct AllData {
    //match lines of json response
    let asset_id_base: String
    let rates: [String: Rate] = [:]
}

struct Rate {
    let time: String
    let assetName: String
    let exchangeRate: Decimal
}
