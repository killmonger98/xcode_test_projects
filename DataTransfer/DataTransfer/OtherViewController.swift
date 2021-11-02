//
//  OtherViewController.swift
//  DataTransfer
//
//  Created by Abhiram Krishna on 27/10/20.
//

import UIKit

protocol DataPassingDelegate {
    func didEnterData(value: String)
}

class OtherViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    var dataDelegate: DataPassingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let text = field.text {
        dataDelegate.didEnterData(value: "\(text)")
        }
        dismiss(animated: true, completion: nil)
    }
    


}
