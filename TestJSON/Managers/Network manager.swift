//
//  Network manager.swift
//  TestJSON
//
//  Created by Apple on 29.06.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    class func fetchDatafromNetwork(completion: @escaping (Input?) -> ()) {
        AF.request("https://pryaniky.com/static/json/sample.json")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(_):
                    do {
                        let input = try JSONDecoder().decode(Input.self, from: dataResponse.data!)
                        completion(input)
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                }
            }
    }
}
