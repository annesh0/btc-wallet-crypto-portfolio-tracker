//
//  Json.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 6/9/22.
//

struct AllData : Decodable {
    //match lines of json response
    let asset_id_base: String
    let rates: [Rate]
}

struct Rate : Decodable {
    let time: String
    let assetName: String
    let exchangeRate: Double
}
