//
//  WundergroundWeatherAPIClient.swift
//  playingWithOAuth
//
//  Created by Eldon Chan on 8/2/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

import UIKit
import CoreLocation

class APIClient: NSObject { 
    
    static let shared = DataStore.sharedDataStore
    
    class func getWeather(completionHandler: (NSDictionary)->()) {
        
        
        let state = shared.currentInfo.state
        var city = shared.currentInfo.city
        
        if city.containsString(" "){
            city = city.stringByReplacingOccurrencesOfString(" ", withString: "_")
        }
        
        
        let urlString = "http://api.wunderground.com/api/c7c9c0a9e2d81fa3/conditions/q/\(state)/\(city).json"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
//        print (urlString)
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseData = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary {
                
                    completionHandler(responseData)
            }
        }
        task.resume()
    }
    
    class func getHourlyWeather(completionHandler: (NSDictionary)->()) {
        
        let state = shared.currentInfo.state
        let city = shared.currentInfo.city
        
//        print("APICITY: \(shared.currentInfo.city)")
        
        let urlString = "http://api.wunderground.com/api/c7c9c0a9e2d81fa3/hourly/q/\(state)/\(city).json"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseData = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary {
                
                completionHandler(responseData)
            }
        }
        task.resume()
    }
    
}
