//
//  NewsFeed.swift
//  ManagedCodable
//
//  Created by Abhiram Krishna on 31/12/20.
//


extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

import Foundation
import CoreData

// MARK: - NEWS FEED
class NewsFeed: Decodable {
    
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
      case status, totalResults, articles
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init()

            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.articles = try container.decode(Array<Article>.self, forKey: .articles) as [Article]

        
//            self.id = try container.decode(Int64.self, forKey: .id)
//            self.label = try container.decode(String.self, forKey: .label)
//            self.completions = try container.decode(Set<TodoCompletion>.self, forKey: .completions) as NSSet
          }
      }


// not using now
// MARK: - ARTICLE
//public class Article: Codable {
//    
//    var author: String?
//    var title: String?
//    var articleDescription: String?
//    var imageURL: String?
//    var publishedAt: String?
//    var content: String?
//    var isFavourite = false
//    
//    enum CodingKeys: String, CodingKey {
//      case author, content, title, articleDescription = "description", imageURL = "urlToImage"
//    }
    

