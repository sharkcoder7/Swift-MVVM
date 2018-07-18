//
//  NetworkManager.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let requestManager : KRNRequestManager
    
    init(apiURL : String) {
        requestManager = KRNRequestManager.init(url: apiURL)
    }
    
    func parseWithDecoder<T>(response : Any?, error : NetworkError?, decodableType : T.Type, completion : (T?, NetworkError?)->Void) where T : Decodable {
        if let error = error {
            completion(nil, error)
            return
        }
        
        print ("response: \(String(describing: response))")
        
        if let str = response as? String {
            print(str)
        }
        
        guard let response = response as? Data else {
            completion(nil, NetworkError.init(originalErrorMessage: "Response is not DATA type"))
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let dict = try JSONSerialization.jsonObject(with: response, options: .allowFragments)
            if let diction = dict as? [String:Any] {
                print(diction as NSDictionary)
            } else if let array = dict as? [[String : Any]] {
                print(array as NSArray)
            }
            let result = try decoder.decode(decodableType, from: response)
            completion(result, nil)
        } catch let error as NSError {
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let mismType, let context):
                    print("Type mismatch error = \(mismType). Context = \(context)")
                default:
                    print("\(decodingError)")
                }
            }
            print(error.localizedDescription)
            completion(nil, NetworkError.init(originalErrorMessage: "Response is not decodable data"))
        }
    }
}

