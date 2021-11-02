//
//  SuggestionNameCell.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 06/01/21.
//

import UIKit

class SuggestionNameCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func setAttribute(name: String) {
        
        nameLabel.text = name
        
    }
    
}
