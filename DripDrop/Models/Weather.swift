//
//  Weather.swift
//  DripDrop
//
//  Created by DevMountain on 9/8/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

struct WeatherService: Codable{
    
    var currently: CurrentWeather
    var weeklyWeatherData: WeeklyWeather
    
    private enum CodingKeys: String, CodingKey{
        
        case currently
        case weeklyWeatherData = "daily"
    }
}

struct CurrentWeather: Codable{
    
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperature: Double
    
}

struct WeeklyWeather: Codable{
    
    var summary: String
    var icon: String
    var data: [DailyWeather]
}

struct DailyWeather: Codable{
    
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperatureMax: Double
    var temperatureMin: Double
    
}
