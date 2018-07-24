//
//  ViewController.swift
//  a
//
//  Created by vietl le on 20/07/2018.
//  Copyright © 2018 vietl le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        let obj = CallAPI()
        var param = [String: Any]()
        param["employeeID"] = "1"
        
        obj.getImageRequest(param: param) { (result) in
            print(result.data ?? "")
            guard let dict = (result.data as? [String: Any]) else {return}
            guard let arrayData = dict["items"] as? Array<[String: Any]> else {return}
            
            if arrayData.count > 0 {
                let object_1 = arrayData[0]
                print("name: ",object_1["Name"] ?? "")
            }
        }
    }

}

