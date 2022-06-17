
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
}


