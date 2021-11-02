//
//  DetailsViewController.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 26/12/20.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var familyLocationLabel: UILabel!
    
    var person: Person?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let person = person {
            personNameLabel.text = person.name
            print(person.objectID)
            if let familyName = person.family?.name {
                familyNameLabel.text = familyName
            }
            if let familylocation = person.family?.location {
                familyLocationLabel.text = familylocation
            } else {
                familyLocationLabel.text = ""
            }
            
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

    func setAttribute(personName: String, familyName: String?) {
        personNameLabel.text = personName
        if let famName = familyName {
            familyNameLabel.text = famName
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "detailToEdit", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "detailToEdit" {

            let vc = segue.destination as? EditPersonViewController
            guard let newVC = vc else {
                print("NIL")
                return
            }
            newVC.person = person
            newVC.modalPresentationStyle = .fullScreen
//            present(newVC, animated: true, completion: nil)
            
        }
        
    }

}
