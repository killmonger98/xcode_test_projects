//
//  ViewController.swift
//  TestingSVProgress
//
//  Created by Abhiram Krishna on 18/11/20.
//

import SVProgressHUD
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Loading..")
    }
    
    
}

