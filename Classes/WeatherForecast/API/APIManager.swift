//
//  APIManager.swift
//  WeatherForecast
//
//  Created by Liu Changhong on 6/6/19.
//  Copyright © 2019 LukeLiu. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    typealias RequestCompletionClosure = (_ weather: CurrentWeather?, _ error: Error?) -> Void
    
    let subDataURL = "https://raw.githubusercontent.com/cjbatin/Swift4-Decoding-JSON-Using-Codable/master/WeatherForecast/StubData/londonWeather.json"
    
    func getWeather(completion: @escaping RequestCompletionClosure){
        
        getJSONFromURL(urlString: subDataURL) { (data, error) in
            
            guard let data = data, error == nil else {
                print("failed to get data")
                return completion(nil, error)
            }
            
            self.createWeatherObjectWith(json: data, completion: { (weather, error) in
                
                if let error = error {
                    print("failed to convert data")
                    return completion(nil, error)
                }
                
                return completion(weather, nil)
                
            })
            
        }
        
    }
    
}

extension APIManager {
    
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void){
        
        guard let url = URL.init(string: urlString) else {
            print("Error: Cannot create URL from urlString")
            return
        }
        
        let urlRequest = URLRequest.init(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                print("Error is not nil when call api")
                return completion(nil, error)
            }
            
            guard let responseData = data else {
                print("data is nil")
                return completion(nil, error)
            }
            
            completion(responseData, nil)
            
        }
        
        task.resume()
        
    }
    
    func createWeatherObjectWith(json: Data, completion: (_ data: CurrentWeather?, _ error: Error?) -> Void) {
        
        do {
            
            let weather = try JSONDecoder().decode(CurrentWeather.self, from: json)
            
            return completion(weather, nil)
            
        } catch let error {
            
            print("Error at creating current weather from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
            
        }
    }
    
}
