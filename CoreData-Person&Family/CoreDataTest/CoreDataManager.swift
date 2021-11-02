//
//  CoreDataManager.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 28/12/20.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    func getContext() -> NSManagedObjectContext {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return context
        
    }
    
}
