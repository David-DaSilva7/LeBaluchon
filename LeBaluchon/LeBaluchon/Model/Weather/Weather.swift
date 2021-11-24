//
//  Weather.swift
//  LeBaluchon
//
//  Created by David Da Silva on 24/11/2021.
//

import Foundation

// MARK: - EntireWeather
struct EntireWeather: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let weatherId: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case main
        case weatherDescription = "description"
        case icon
    }
}

enum Cities: String {
    case metz = "2988507"
    case newYork = "5128581"
}
