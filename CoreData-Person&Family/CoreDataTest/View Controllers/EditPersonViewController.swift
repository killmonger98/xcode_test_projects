//
//  EditPersonViewController.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 06/01/21.
//

import UIKit
import CoreData

class EditPersonViewController: UIViewController {

    var person: Person?
    var items: [Person]?
    var families: [Family]?
    
    var selectedFamily: Family?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.isHidden = true
        setAttributes()
    }
    
    // MARK: - FETCH
    func fetchData() {
        
        do {
            let request = Person.fetchRequest() as NSFetchRequest<Person>
//            request.predicate = NSPredicate(format: "name BEGINSWITH %@", "B")
            self.items = try context.fetch(request)
            
        } catch {
            print("Error while fetching data")
        }
        
        do {
            let request = Family.fetchRequest() as NSFetchRequest<Family>
//            request.predicate = NSPredicate(format: "name BEGINSWITH %@", "B")
            self.families = try context.fetch(request)
            //-com.apple.CoreData.SQLDebug 1
        } catch {
            print("Error while fetching data")
        }

        for family in families! {
            print(family.name)
        }

    }
    
    func setAttributes() {
        nameTextField.text = person?.name
        familyTextField.text = person?.family?.name
    }
    
    func saveButtonTapped() {
        
        if selectedFamily != nil {
            if selectedFamily?.name == familyTextField.text {
                // no need for new family creation
                // remove person from old family
                let fam = person?.family
                person?.family?.removeFromMember(person!)
                // add person to selected family
                context.delete(fam!)
                selectedFamily?.addToMember(person!)
                person?.family?.name = selectedFamily?.name
            } else {
                // remove person from old family
                let fam = person?.family
                person?.family?.removeFromMember(person!)
                
                context.delete(fam!)
                let family = Family(context: context)
                family.name = familyTextField.text
                family.location = ""
                family.addToMember(person!)
                // check if family already exists
                // create new family
            }
        } else {
            // remove peron from old family
            // create new family
            let fam = person?.family
            person?.family?.removeFromMember(person!)
            // remove family if it does not have any other relations
//            context.delete((person?.family)!)
            context.delete(fam!)
            let family = Family(context: context)
            family.name = familyTextField.text
            family.location = ""
            family.addToMember(person!)
        }
        
        do {
            try context.save()
        } catch {
            print("Error while saving new person")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        saveButtonTapped()
        
        
    }
    
    
}

// MARK: - TEXT FIELD DELEGATE METHODS
extension EditPersonViewController: UITextFieldDelegate {
    
    /// to switch and dismiss keyboard on tapping return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            textField.resignFirstResponder()
            familyTextField.becomeFirstResponder()
        } else if textField == familyTextField {
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    /// to get current active text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == familyTextField {
            tableView.isHidden = false
        }
        
    }
    
    /// to set active text field to nil when user is done editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == familyTextField {
            tableView.isHidden = true
        }
        
    }
    
}

extension EditPersonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return families?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emptyCell = UITableViewCell()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personNameCell", for: indexPath) as? SuggestionNameCell else {
            return emptyCell
        }
        
        let fam = self.families?[indexPath.row]

        guard let familyName = fam?.name else {
            return emptyCell
        }
        
        cell.setAttribute(name: familyName)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fam = self.families?[indexPath.row]
        selectedFamily = fam
        guard let familyName = fam?.name else {
            return
        }
        
        familyTextField.text = familyName
        familyTextField.resignFirstResponder()
        
    }
    
    
}
