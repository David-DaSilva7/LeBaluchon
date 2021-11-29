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
    let temp: Double
    let feels_like: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
    }
}

// MARK: - Weather
struct Weather: Codable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description
    }
}

enum Cities: String {
    case metz = "2992402"
    case newYork = "5128581"
}
