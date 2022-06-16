//
//  PersistenceManager.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/14/22.
//

import Foundation
class PersistenceManager {
    static let shared = PersistenceManager()
    private init() {}
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        //print(documentsDirectory)
        return documentsDirectory
    }
    
    func save(coins: codableCoins){
        //print("I was called 1")
        let path = documentsDirectory().appendingPathComponent("coins.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(coins)
        try! encoded.write(to: path)
    }
    
    func load() -> codableCoins?{
        //print("I was called 2")
        let path = documentsDirectory().appendingPathComponent("coins.plist")
        let plistDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: path){
            //print("I was called 3")
            let decoded = try! plistDecoder.decode(codableCoins.self, from: data)
            return decoded
        }
        return nil
    }
}
