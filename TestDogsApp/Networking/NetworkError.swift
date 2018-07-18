//
//  NetworkError.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import Foundation

struct NetworkError {
    init(statusCode : Int? = nil, originalErrorMessage : String, rawData : Data? = nil) {
        self.statusCode = statusCode
        self.originalErrorMessage = originalErrorMessage
        self.rawData = rawData
    }
    
    init(statusCode : Int, rawData : Data?) {
        self.statusCode = statusCode
        self.rawData = rawData
    }
    
    var statusCode : Int?
    var originalErrorMessage: String = ""
    
    var rawData : Data?
    
    var isContentError : Bool {
        guard let statusCode = self.statusCode else {return false}
        return statusCode == 409
    }
    
    var contentErrorMessage : String? {
        guard let jsonDict = jsonDictErrorData else {return nil}
        return jsonDict["message"] as? String
    }
    
    var contentErrorCode : Int? {
        guard let jsonDict = jsonDictErrorData else {return nil}
        return jsonDict["code"] as? Int
    }
    
    var jsonDictErrorData : [String : Any]? {
        guard let rawData = self.rawData else {return nil}
        do {
            let dict = try JSONSerialization.jsonObject(with: rawData, options: .allowFragments) as? [String:Any]
            return dict
        } catch _ as NSError {
            return nil
        }
    }
    
    var stringErrorData : String? {
        guard let rawData = self.rawData else {return nil}
        return String(data: rawData, encoding: .utf8)
    }
}
