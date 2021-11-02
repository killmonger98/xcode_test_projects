//
//  ViewController.swift
//  DataTransfer
//
//  Created by Abhiram Krishna on 27/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "other") as! OtherViewController
        vc.modalPresentationStyle = .fullScreen
        vc.dataDelegate = self
        present(vc, animated: true)
        
    }


}

extension ViewController: DataPassingDelegate {

    func didEnterData(value: String) {
            label.text = "\(value)"
    }
}
