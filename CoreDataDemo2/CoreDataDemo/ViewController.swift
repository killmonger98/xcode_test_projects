//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Abhiram Krishna on 21/12/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Person]?
    
    override func viewDidLoad() {
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first)
        super.viewDidLoad()
        title = "List"
//        relationshipDemo()
        fetchData()
        reloadTableView()
    }
    
// MARK: - FETCH DATA
    func fetchData() {
//        DispatchQueue.main.async {
            // fetch data from core data
            do {
                let request = Person.fetchRequest() as NSFetchRequest<Person>
                
                //set filtering
                //let pred = NSPredicate(format: "name CONTAINS %@", "Ambadi")
                //request.predicate = pred
                
                //sort data
                
    //            let sort = NSSortDescriptor(key: "name", ascending: true)
    //            request.sortDescriptors = [sort]
                
                self.items = try self.context.fetch(request)
                // sometimes fetchData() might be called from background thread
    //            reloadTableView()
            } catch {
                print("Error while fetching data")
            }
//        }
        
        
    }
    
    
    func sort() {
        
        self.items = self.items?.sorted(by: { (obj1, obj2) -> Bool in
               let obj1Name = obj1.name ?? ""
               let obj2Name = obj2.name ?? ""
               return (obj1Name.localizedCaseInsensitiveCompare(obj2Name) == .orderedAscending)
            })
        
    }
    
    func reloadTableView() {
        
//        DispatchQueue.main.async {
            self.tableView.reloadData()
//        }
        
    }
    
    // MARK: - RELATIONSHIP
    func relationshipDemo() {
        
        // create a family
        let family = Family(context: context)
        family.name = "ABC Family"
        
        // create a person
        let person = Person(context: context)
        person.name = "Babu"
        
//        person.family = family
        // add person to fami ly
        family.addToPeople(person)
        family.location = "TVM"
        // save conext
        do {
        try context.save()
        } catch {
            
        }
        
    }
    
    // MARK: - ADD
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Person", message: "What is the name?", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        // configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            // thread safe - runs in main thread
            // when add button is tapped
            // get text field for the alert
            let textfield = alert.textFields![0]
            let textfield1 = alert.textFields![1]
            
            if textfield.text == "" {
                return
            }
            
            // create a family
            let family = Family(context: self.context)
            if textfield.text == "" {
                family.name = nil
            }
            family.name = textfield1.text!

            
            let newPerson = Person(context: self.context)
            newPerson.name = textfield.text
            newPerson.age = 18
            newPerson.gender = "male"
            
            family.addToPeople(newPerson)
            family.location = "TVM"
            
            print(newPerson.id)
            // new object is added to the list - to avoid db hit
            self.items?.append(newPerson)
            
            // save data
            let newQueue = DispatchQueue(label: "com.abhiram.ambadi")
            
            newQueue.async {
                do {
                    try self.context.save()
                } catch {

                }
            }
            
            // reload table view
            // calling form background thread
//            self.fetchData()
            self.reloadTableView()
            
        }
        
        alert.addAction(submitButton)

        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

// MARK: - TABLE VIEW DELEGATE
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let person = self.items?[indexPath.row]
        cell?.textLabel?.text = person?.name
        return cell ?? UITableViewCell()
    }
    
    // MARK: - DELETE
    // delete row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // let create swipe action
        let action = UIContextualAction(style: .destructive, title: "Remove") { (action, view, completionHandler) in
            
            let personToRemove = self.items?[indexPath.row]
            
            // remove item from coredata - using context
            self.context.delete(personToRemove!)
            
            // save the data
            do {
                try self.context.save()
            } catch {
                
            }
            
            // refetch the data
//            self.fetchData()
            for item in self.items! {
                print(item.name)
            }
            self.reloadTableView()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // MARK: -  UPDATE
    // on tapping row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // select person
        let person = self.items?[indexPath.row]
        
        if person?.family?.location != nil {
            print(person?.family?.name)
        }
        
        // create alert
        let alert = UIAlertController(title: "Edit Person", message: "Change name", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = person?.name
        
        // configure button handler
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            // get text field
            let textfield = alert.textFields![0]
            
            // edit name
            person?.name = textfield.text
            
            // save data
            do {
                try self.context.save()
            } catch {
                
            }
            
//            self.fetchData()
            self.reloadTableView()

        }
        
        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)
        sort()
    }
}
