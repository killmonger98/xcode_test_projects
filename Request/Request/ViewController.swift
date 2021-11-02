//
//  ViewController.swift
//  Request
//
//  Created by Abhiram Krishna on 25/10/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var url = "https://api.sunrise-sunset.org/json?date=2020-01-01&lat=36.7201600&lng=-4.4203400&formatted=0"
        getData(from: url)
    }
    
    private func getData(from url: String ){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data else {
                print("Somthing went wrong")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("Failed to convert")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.status)
            print(json.Result.solarnoon)
        })
        
        task.resume()
    }

}




struct Response: Codable {
    let Result: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solarnoon: String
    let day_length: Int
    let civil_twilight_begin: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

/*
 {"results":{"sunrise":"2020-01-01T07:30:08+00:00","sunset":"2020-01-01T17:12:21+00:00","solar_noon":"2020-01-01T12:21:15+00:00","day_length":34933,"civil_twilight_begin":"2020-01-01T07:01:28+00:00","civil_twilight_end":"2020-01-01T17:41:01+00:00","nautical_twilight_begin":"2020-01-01T06:29:10+00:00","nautical_twilight_end":"2020-01-01T18:13:20+00:00","astronomical_twilight_begin":"2020-01-01T05:57:43+00:00","astronomical_twilight_end":"2020-01-01T18:44:46+00:00"},
 "status":"OK"}
 
 */
