//
//  ServicesURL.swift
//  LeBaluchon
//
//  Created by David Da Silva on 25/10/2021.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - Fixer
class FixerExchangeRate {
    // MARK: - Properties
    static private let endpoint = "http://data.fixer.io/api/latest"
    static private var parameters: String {
        return "?symbols=USD"
    }
    static private let accessKey = "&access_key=\(APIKeys.fixerExchangeRate)"
    
    static var url: String {
        return FixerExchangeRate.endpoint + FixerExchangeRate.parameters + FixerExchangeRate.accessKey
    }
}


// MARK: - Google Translation
class GoogleTranslation {
    // MARK: - Properties
    static private let endpoint = "https://translation.googleapis.com/language/translate/v2"
    static private let accessKey = "?key=\(APIKeys.GoogleTranslation)"
    static private var parameters: String {
        return "&source=\(Languages.sourceLanguageCodeISO)&target=\(Languages.targetLanguageCodeISO)&format=text&q="
    }
    static var url: String {
        return GoogleTranslation.endpoint + GoogleTranslation.accessKey + GoogleTranslation.parameters
    }
}

// MARK: - Open Weather
class OpenWeather {
    // MARK: - Properties
    static private let endpoint = "https://api.openweathermap.org/data/2.5/weather"
    static private let accessKey = "&appid=\(APIKeys.OpenWeatherMap)"
    static private var parameters: String {
        return "?units=metric&id=\(city)&lang=fr"
        
    }
    static var city = ""
    static var url: String {
        return OpenWeather.endpoint + OpenWeather.parameters + OpenWeather.accessKey
    }
}

