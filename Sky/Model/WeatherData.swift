//
//  WeatherData.swift
//  Sky
//
//  Created by Vassily on 2018/7/1.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeatherData
    let daily: WeekWeatherData
    
    struct CurrentWeatherData: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
    
    struct WeekWeatherData: Codable {
        let data: [ForecastData]
    }
}

extension WeatherData.CurrentWeatherData: Equatable {
    
    public static func == (lhs: WeatherData.CurrentWeatherData, rhs: WeatherData.CurrentWeatherData) -> Bool {
        return lhs.time == rhs.time && lhs.summary == rhs.summary && lhs.icon == rhs.icon && lhs.temperature == rhs.temperature && lhs.humidity == rhs.humidity
    }
}

extension WeatherData.WeekWeatherData: Equatable {
    public static func == (lhs: WeatherData.WeekWeatherData, rhs: WeatherData.WeekWeatherData) -> Bool {
        return lhs.data == rhs.data
    }
}

extension WeatherData: Equatable {
    
    public static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.currently == rhs.currently && lhs.daily == rhs.daily
    }
}
