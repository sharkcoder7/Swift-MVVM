//
//  NetworkManager+Dogs.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getRandomDogs(completion : @escaping (DogsResponse?, NetworkError?) -> Void) {
        requestManager.requestJSON(method: .get, shortURL: "breeds/image/random/50", params: nil, headerParams: nil, parseFormat: .none) { [weak self] (response, error) in
            guard let `self` = self else {return}
            self.parseWithDecoder(response: response, error: error, decodableType: DogsResponse.self, completion: completion)
        }
    }
    
    
}
