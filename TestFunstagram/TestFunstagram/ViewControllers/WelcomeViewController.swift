//
//  WelcomeViewController.swift
//  TestFunstagram
//
//  Created by Abhiram Krishna on 01/11/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeTextField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var firstname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "\(firstname ?? "")"
    }
    
    @IBAction func welcomeButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let hvc = segue.destination as? HelloViewController else { return }
    if let firstname = firstname, let lastname = welcomeTextField.text {
    hvc.fullname = "\(firstname) \(lastname)"
    }
    }
    
}
