//
//  AddPersonViewController.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 26/12/20.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if personNameTextField.text != "" {
            
            let personName = personNameTextField.text
            let newPerson = Person(context: context)
            newPerson.name = personName
            
            if familyNameTextField.text != "" {
                let family = Family(context: context)
                family.name = familyNameTextField.text
                if locationTextField.text != "" {
                    family.location = locationTextField.text
                }
                family.addToMember(newPerson)
            }
            
            let queue = DispatchQueue(label: "com.abhiram.queue1")
            
            queue.async {
                do {
                    try context.save()
                } catch {
                    print("Error while saving new person")
                }
            }
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
