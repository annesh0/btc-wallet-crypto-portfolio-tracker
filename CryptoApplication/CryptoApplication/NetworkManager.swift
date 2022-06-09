
//
//  NetworkManager.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 6/6/22.
//

import Alamofire
import Foundation

class NetworkManager {
    /*
    static func getAllPosts(completion: @escaping ([Post]) -> Void) {
        let endpoint = "\(host)/posts/all/"
        //let params: [String:String] = [
          //  "key": "value"
        //]
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode([Post].self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed Decoding")
                }
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
     */
    static func getAllCoinValues(completion: @escaping ([AllData]) -> Void) {
        let endpoint = "https://rest.coinapi.io/v1/exchangerate/USD?apikey=2538BC37-2458-49AC-82A8-772B98788B29&invert=true&output_format=cs"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode([AllData].self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


