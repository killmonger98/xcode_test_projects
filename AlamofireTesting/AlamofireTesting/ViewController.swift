//
//  ViewController.swift
//  AlamofireTesting
//
//  Created by Abhiram Krishna on 19/11/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://api.androidhive.info/contacts/").response {
            (response) in
            debugPrint(response)
        }
        
        
        
        AF.request("http://httpbin.org/get").responseJSON(completionHandler: { (response) in
            print(response)
            
        })
    }


}

