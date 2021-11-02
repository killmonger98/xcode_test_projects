//
//  TestViewController.swift
//  UIElements
//
//  Created by Abhiram Krishna on 28/10/20.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    var cities = ["London", "New York City", "Trivandrum", "Istanbul", "Tokyo", "Dubai"]
    
    let cityPicker = UIPickerView()
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityTextField.inputView = cityPicker
        cityTextField.textAlignment = .center
    }
    
    // MARK: - City Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTextField.text = cities[row ]
        cityTextField.resignFirstResponder()
    }
    
    // MARK: - Date Picker
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //text allignment
        dateTextField.textAlignment = .center
        
        //done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        //add done button to toolbar
        toolbar.setItems([doneButton], animated: true)
        
        //assign toolbar
        dateTextField.inputAccessoryView = toolbar
        
        //assign date picker to text field
        dateTextField.inputView = datePicker
        
        //date picker mode
        datePicker.datePickerMode = .date
        
    }
    
    @objc func donePressed() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}
