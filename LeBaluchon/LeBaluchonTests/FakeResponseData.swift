//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by David Da Silva on 30/11/2021.
//

import Foundation

class FakeResponseData {
    // MARK: - HTTP status code
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil)!
    
    // MARK: - Error
    class SimpleError: Error {}
    static let error = SimpleError()
    
    // MARK: - Incorrect data
    static let incorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Fixer
    static var exchangeRateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "fixerExchangeRate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // MARK: - Google Translate
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "googleTranslate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // MARK: - OpenWeather
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "openWeather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
}
