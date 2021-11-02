//
//  Family+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Abhiram Krishna on 06/01/21.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }

    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var member: NSSet?

}

// MARK: Generated accessors for member
extension Family {

    @objc(addMemberObject:)
    @NSManaged public func addToMember(_ value: Person)

    @objc(removeMemberObject:)
    @NSManaged public func removeFromMember(_ value: Person)

    @objc(addMember:)
    @NSManaged public func addToMember(_ values: NSSet)

    @objc(removeMember:)
    @NSManaged public func removeFromMember(_ values: NSSet)

}

extension Family : Identifiable {

}
