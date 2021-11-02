//
//  ViewController.swift
//  TestFunstagram
//
//  Created by Abhiram Krishna on 01/11/20.

import UIKit

class HelloViewController: UIViewController {
    
    @IBOutlet weak var helloTextField: UITextField!
    @IBOutlet weak var helloLabel: UILabel!
    
    var fullname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
        guard let fullname = fullname else { return }
        helloTextField.text = ""
        helloLabel.text = "\(fullname)"
    }
    
    @IBAction func helloButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let wvc = segue.destination as? WelcomeViewController else { return }
        wvc.firstname = helloTextField.text
    }
    
    @IBAction func performUnwindSegueOperation(_ sender: UIStoryboardSegue) {
        print("Control reached here")
    }
    
    func setView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

