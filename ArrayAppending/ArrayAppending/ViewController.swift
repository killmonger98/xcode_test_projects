//
//  ViewController.swift
//  ArrayAppending
//
//  Created by Abhiram Krishna on 22/10/20.
//

import RealmSwift
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userEmail.delegat = self
//        middleName.delegate = self
//        lastName.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmail.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == userEmail {
             textField.resignFirstResponder()
             firstName.becomeFirstResponder()
          } else if textField == firstName {
             textField.resignFirstResponder()
             lastName.becomeFirstResponder()
          } else if textField == lastName {
             textField.resignFirstResponder()
          }
         return true
        }
    

    @IBAction func enterTapped(_ sender: Any) {
        lastName.resignFirstResponder()
        var name: [String] = []
        let email = userEmail.text?.isEmailValid()
        var valid: String = "Invalid Email"
        if email! {
            valid = "Valid Email"
        }
        textView.text = String("\(valid) \n \(userEmail.text!) \n Name: \(firstName.text!) \(lastName.text!)")
        
        if let fname = userEmail.text {
            name.append(fname)
        }
        if let mname = firstName.text {
            name.append(mname)
        }
        if let lname = lastName.text {
            name.append(lname)
        }
        print(name)
    }
    
    
}


extension String {
    func isEmailValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
