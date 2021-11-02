//
//  ViewController.swift
//  IHProgressTesting
//
//  Created by Abhiram Krishna on 22/11/20.
//

import UIKit
import IHProgressHUD
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    
    var isPlaying: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        IHProgressHUD.show()
    //        DispatchQueue.global(qos: .default).async(execute: {
    //            for _ in Range(1...10000000) {
    //
    //            }
    //        IHProgressHUD.dismiss()
    //        })
    //    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        if isPlaying {
            isPlaying = false
            IHProgressHUD.set(defaultStyle: .dark)
            IHProgressHUD.show(withStatus: "Fetching Data..")
//            IHProgressHUD.show(progress: 0.6, status: "Loading..")
        } else {
            isPlaying = true
            IHProgressHUD.dismiss()
        }
        
    }
    
}

