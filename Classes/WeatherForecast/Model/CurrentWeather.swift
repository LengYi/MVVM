//
//  CurrentWeather.swift
//  MVVM
//
//  Created by ice on 2021/3/4.
//

import Foundation

struct Coord: Codable {
    let lat: Float
    let lon: Float
}

struct WeatherDetails: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Float
    let pressure: Int
    let humidity: Int
    let temp_min: Float
    let temp_max: Float
}

struct Wind: Codable {
    let speed: Float
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let message: Float
    let country: String
    let sunrise: Float
    let sunset: Float
}

struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [WeatherDetails]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
}
