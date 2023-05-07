//
//  Wheather.swift
//  WheatherApp
//
//  Created by Vovo on 07.05.2023.
//
import Foundation

struct Wheather: Codable {
    let current_weather: CurentWheather
    let hourly: Hourly
}

struct CurentWheather: Codable {
    let time: String
    let temperature: Double
    let windspeed: Double
}

struct Hourly: Codable {
    let time: [String]
    let windspeed_10m: [Double]
    let temperature_2m: [Double]
}

