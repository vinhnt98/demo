//
//  CallAPI.swift
//  a
//
//  Created by vietl le on 20/07/2018.
//  Copyright © 2018 vietl le. All rights reserved.
//

import UIKit

class CallAPI: NSObject {
    
    func getImageRequest(param: [String: Any]?, callBack: CompletionRequest) {
        NetWork.shared.requestWith(method: .Post, apiName: ApiNameImageRequest, param: param, callBack: callBack)
    }
    
    // new a
    //c
}
