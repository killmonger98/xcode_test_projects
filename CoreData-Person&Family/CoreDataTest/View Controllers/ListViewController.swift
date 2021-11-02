//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 26/12/20.
//

import UIKit
import CoreData

let context = CoreDataManager.shared.getContext()

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        performSelector(inBackground: #selector(run), with: nil)
//        let thread = Thread(target:self, selector: #selector(run), object:nil)
//        thread.start()
        
        fetchData()
        tableView.reloadData()
    }
    
    @objc func run() {
        print("Hello World")
        fetchData()
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ListToAddPerson", sender: nil)
    }
    
    // MARK: - FETCH
    func fetchData() {
        
        do {
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            
//            request.predicate = NSPredicate(format: "name BEGINSWITH %@", "B")
            //set filtering
            //let pred = NSPredicate(format: "name CONTAINS %@", "Ambadi")
            //request.predicate = pred
            
            //sort data
            
//            let sort = NSSortDescriptor(key: "name", ascending: true)
//            request.sortDescriptors = [sort]
            
            self.items = try context.fetch(request)
            
        } catch {
            print("Error while fetching data")
        }
        
    }
    
    // MARK: - PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ListToAddPerson" {
            // on tapping plus button
            let vc = segue.destination as? AddPersonViewController
            guard let newVC = vc else {
                print("NIL")
                return
            }
            newVC.modalPresentationStyle = .fullScreen
//            present(newVC, animated: true, completion: nil)
            
        } else if segue.identifier == "ListToDetailsScreen" {
            // on tapping the row
            let person = sender as? Person

            let vc = segue.destination as? DetailsViewController
            guard let newVC = vc else {
                print("NIL")
                return
            }
            newVC.person = person
            newVC.modalPresentationStyle = .fullScreen
//            present(newVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func unwindSegueToListView(_ sender: UIStoryboardSegue) { }
    
//    func presentVC(id: String, type: ) {
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: id) as? type
//        guard let newVC = vc else {
//            print("NIL")
//            return
//        }
//        newVC.modalPresentationStyle = .fullScreen
//        present(newVC, animated: true, completion: nil)
//
//    }
    
}

// MARK: - TABLE VIEW DELEGATE
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emptyCell = UITableViewCell()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListCell else {
            return emptyCell
        }
        
        let person = self.items?[indexPath.row]
        
        guard let personName = person?.name else {
            return emptyCell
        }
        
        cell.setAttribute(name: personName)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ListToDetailsScreen", sender: items?[indexPath.row])
        
    }
    
    // MARK: - DELETE
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // let create swipe action
        let action = UIContextualAction(style: .destructive, title: "Remove") { (action, view, completionHandler) in
            
            let personToRemove = self.items?[indexPath.row]
            
            self.removePerson(personToRemove!)
        }
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    func removePerson(_ personToRemove: Person) {
        
        // remove item from coredata - using context
        context.delete(personToRemove)

        // save the data
        do {
            try context.save()
        } catch {
            
        }

        self.fetchData()
        tableView.reloadData()
        
    }
    
}

