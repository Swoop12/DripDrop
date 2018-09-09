//
//  WeatherController.swift
//  DripDrop
//
//  Created by DevMountain on 9/8/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherController{
    
    static let shared = WeatherController()
    private init() {}
    
    var dailyWeathers: [DailyWeather]?
    
    var currentWeather: CurrentWeather?
    
    let locatioinManager = CLLocationManager()
    
    
    let baseURL = URL(string: "https://api.darksky.net/forecast/")
    let apiSecret = "8940fc22c0ed6b892125705b44e40965"
    
    func fetchWeeklyWeather(latitude: Double, longitude: Double, completion: @escaping (([DailyWeather]?) -> Void)){
        
        //1) Getting your URL Right
        guard let baseUrl = baseURL else {completion(nil) ; return}
        var url = baseUrl.appendingPathComponent(apiSecret)
        url.appendPathComponent("\(latitude),\(longitude)")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "exclude", value: "[minutely,hourly,alerts,flags]")]

        guard let finishedUrl = components?.url else {completion(nil) ; return}
        
        print(finishedUrl.absoluteString)
        
        //2) Calling the DataTask step 2.5(Decoding your data)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            
            print("\(response ?? URLResponse())")
            
            guard let data = data else { completion(nil) ; return }
            
            let decoder = JSONDecoder()
            do{
                let weatherService = try decoder.decode(WeatherService.self, from: data)
                let dailyWeathers = weatherService.weeklyWeatherData.data
                self.dailyWeathers = dailyWeathers
                self.currentWeather = weatherService.currently
                completion(dailyWeathers)
                
            }catch {
                print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
                completion(nil)
            }
            //Make sure you call dot resume
        }.resume()
    }
}
