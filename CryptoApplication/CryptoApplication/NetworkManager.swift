
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
    typealias APIResponse = ((_ response: Any?, _ error: Error?) -> Void)
    
    static func getAllCoinValues(completion: @escaping APIResponse) {
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/data"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                //let jsonDecoder = JSONDecoder()
                if let userResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completion(userResponse, nil)
                } else {
                    print("Failed")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getNewsArticles(completion: @escaping APIResponse){
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/news"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                //let jsonDecoder = JSONDecoder()
                if let userResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completion(userResponse, nil)
                } else {
                    print("Failed")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getOldCoinValues(completion: @escaping APIResponse) {
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/previousData"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                //let jsonDecoder = JSONDecoder()
                if let userResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completion(userResponse, nil)
                } else {
                    print("Failed")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getMonthlyBTCPrice(completion: @escaping APIResponse){
        let endpoint = "https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-18T00:00:00&time_end=2022-06-17T00:00:00"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch(response.result) {
            case .success(let data):
                //let jsonDecoder = JSONDecoder()
                if let userResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completion(userResponse, nil)
                } else {
                    print("Failed")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


