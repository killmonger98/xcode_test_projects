//
//  ListCell.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 26/12/20.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func setAttribute(name: String) {
        
        nameLabel.text = name
        
    }
}
