//
//  NetWork.swift
//  a
//
//  Created by vietl le on 20/07/2018.
//  Copyright © 2018 vietl le. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

enum Method_: String {
    case Post = "POST"
    case Get = "GET"
}

typealias CompletionRequest = ((_ resutl: Result)->Void)?

class NetWork: AFHTTPSessionManager {
    
    static let shared: NetWork = NetWork(baseURL: URL(string: "https://ptquang9701.000webhostapp.com/testExample/imageRequest.php"), sessionConfiguration: nil)
    
    override init(baseURL url: URL?, sessionConfiguration configuration: URLSessionConfiguration?) {
        super.init(baseURL: url, sessionConfiguration: configuration)
        let request = AFHTTPRequestSerializer()
        let response = AFHTTPResponseSerializer()
        
        let acceptableTypes = NSSet(set: self.responseSerializer.acceptableContentTypes ?? Set<String>())
        acceptableTypes.addingObjects(from: ["application/json","text/html", "text/json", "image/png", "image/jpeg", "image/jpg"])
        response.acceptableContentTypes = acceptableTypes as? Set<String>
        
        self.securityPolicy.allowInvalidCertificates = true
        self.securityPolicy.validatesDomainName = false
        
        request.timeoutInterval = 30
        
        
        self.requestSerializer = request
        self.responseSerializer = response
        self.reachabilityManager.startMonitoring()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func requestWith(method: Method_, apiName: String ,param: [String: Any]?, callBack: CompletionRequest) {
        
        let url = (self.baseURL?.absoluteString)! + apiName
        
        let request = self.requestSerializer.request(withMethod: method.rawValue, urlString: url, parameters: param, error: nil)
        
        let task = self.dataTask(with: request as URLRequest, uploadProgress: nil, downloadProgress: nil) { (response, responseObject, error) in
            let result = Result.init(withResponse: response, dataResponse: responseObject, error: error)
            callBack?(result)
        }
        
        task.resume()
    }
}
