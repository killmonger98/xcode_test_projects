//
//  Article+CoreDataClass.swift
//  ManagedCodable
//
//  Created by Abhiram Krishna on 31/12/20.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject, Decodable {

//    var author: String?
//    var title: String?
//    var articleDescription: String?
//    var imageURL: String?
//    var publishedAt: String?
//    var content: String?
//    var isFavourite = false

    enum CodingKeys: String, CodingKey {
      case author, content, title, articleDescription = "description", imageURL = "urlToImage"
    }
    
    required convenience public init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

        self.init(context:context)

            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(String.self, forKey: .author)
        self.content = try container.decode(String.self, forKey: .content)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.title = try container.decode(String.self, forKey: .title)
        articleDescription = try container.decode(String.self, forKey: .articleDescription)
        
      }
    
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

//import Foundation
//import CoreData
//
//
//extension Article {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
//        return NSFetchRequest<Article>(entityName: "Article")
//    }
//
//    @NSManaged public var author: String?
//    @NSManaged public var articleDescription: String?
//    @NSManaged public var content: String?
//    @NSManaged public var imageURL: String?
//    @NSManaged public var title: String?
//    @NSManaged public var isFavourite: Bool
//
//}
//
//extension Article : Identifiable {
//
//}
//Article+CoreDataProperties.swift

