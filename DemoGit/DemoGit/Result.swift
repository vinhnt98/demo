//
//  Result.swift
//  a
//
//  Created by vietl le on 20/07/2018.
//  Copyright © 2018 vietl le. All rights reserved.
//

import UIKit

class Result: NSObject {
    var statuscode: Int!
    var data: Any?
    var error: Error?
    var message: String?
    
    init(withResponse responseURL: URLResponse, dataResponse: Any?, error: Error?) {
        var dictData: [String: Any]?
        if let string = dataResponse as? String, let data = string.data(using: String.Encoding.utf8) {
            do {
                try dictData = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
            } catch let error {
                print(error)
            }
        } else if let data = dataResponse as? Data {
            do {
                dictData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
            } catch let error {
                print(error)
            }
        } else if let dicS = dataResponse as? [String: Any] {
            dictData = dicS
        }
        
       
        if let dicS = dictData {
            self.data = dicS
            self.message = dicS["message"] as? String
        }
        self.statuscode = (responseURL as! HTTPURLResponse).statusCode
        self.error = error
    }
    
}
