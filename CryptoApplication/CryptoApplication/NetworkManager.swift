
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
    
    static func getAllCoinValues(completion: @escaping APIResponse, finished: @escaping ()->()) {
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/data"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                //let jsonDecoder = JSONDecoder()
                if let userResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completion(userResponse, nil)
                    finished()
                } else {
                    print("Failed")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getNewsArticles(completion: @escaping APIResponse, finished: @escaping ()->()){
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/news"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //process response
            switch(response.result) {
            case .success(let data):
                //let jsonDecoder = JSONDecoder()
                if let userResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completion(userResponse, nil)
                    finished()
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
    
    static func getCoinWeeklyData(completion: @escaping APIResponse, internalAssetID: Int){
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/monthly/" + String((internalAssetID + 2) % 15)
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
    
    static func getCoinMonthlyData(completion: @escaping APIResponse, internalAssetID: Int){
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/monthly/" + String(internalAssetID)
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
    
    static func getCoinYearlyData(completion: @escaping APIResponse, internalAssetID: Int){
        let endpoint = "https://annesh-dylan-crypto-app.herokuapp.com/monthly/" + String((internalAssetID + 1) % 15)
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


