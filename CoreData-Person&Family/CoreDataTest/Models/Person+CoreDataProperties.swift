//
//  Person+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 06/01/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int64
    @NSManaged public var name: String?
    @NSManaged public var family: Family?

}

extension Person : Identifiable {

}
