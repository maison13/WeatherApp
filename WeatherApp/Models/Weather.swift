//
//  Wheather.swift
//  WheatherApp
//
//  Created by Vovo on 07.05.2023.
//
import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let latitude, longitude: Double
    let timezone: String
    let hourly: Hourly
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case hourly
        case daily
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let time: [String]
    let weathercode: [Int]
    let temperatureMax: [Double]
    let temperatureMin: [Double]
    let sunrise: [String]
    let sunset: [String]
    let windspeedMax: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case weathercode
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case sunrise
        case sunset
        case windspeedMax = "windspeed_10m_max"
    }
}

// MARK: - Hourly
struct Hourly: Decodable {
    let time: [String]
    let temperature: [Double]
    let weathercode: [Int]
    let windspeed: [Double]
    let isDay: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weathercode
        case windspeed = "windspeed_10m"
        case isDay = "is_day"
    }
}

// MARK: - WeatherCodeValue
struct WeatherCodeValue: Decodable {
    let day: Day
    let night: Day
}

// MARK: - Day
struct Day: Decodable {
    let description: String
    let image: String
}

typealias WeatherCode = [String: WeatherCodeValue]



