//
//  ViewController.swift
//  ManagedCodable
//
//  Created by Abhiram Krishna on 31/12/20.
//

import UIKit

class ViewController: UIViewController {

    var newsfeed: [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        parseAndPrint()
        
    }

    
    func parseAndPrint() {
        
        let decoder = JSONDecoder()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = managedContext
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=927bb7af880d45b4b4526d4037c4c3c7")!

            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
              if let error = error {
                print("Error with fetching films: \(error)")
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
              }
                print(data)
                
              if let data = data,
                let newsFeed = try? decoder.decode(NewsFeed.self, from: data) {
                self.newsfeed = newsFeed.articles!
                print("---------")
                print(newsFeed)
                print("---------")
                print(self.newsfeed[1].author)
                print(self.newsfeed[2].articleDescription)
              }
            }).resume()
        
    }

}

