
import CoreData


class LocationMigrationV1toV3: NSEntityMigrationPolicy {

    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {

        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)

        // look up location
        var locationInstance: NSManagedObject?

        let locationName = sInstance.value(forKey: "location") as! String

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        fetchRequest.predicate = NSPredicate(format: "name == %@", locationName)
        let results = try manager.destinationContext.fetch(fetchRequest)
        if let resultInstance = results.last as? NSManagedObject {
            locationInstance = resultInstance
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Location", in: manager.destinationContext)
            locationInstance = NSManagedObject(entity: entity!, insertInto: manager.destinationContext)
            locationInstance?.setValue(locationName, forKey: "name")

        }
        // get destination location
        let destResults = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance])
        if let destinationLocation = destResults.last {
            destinationLocation.setValue(locationInstance, forKey: "location")
        }


    }

}
