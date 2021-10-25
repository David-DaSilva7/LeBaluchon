//
//  ServicesURL.swift
//  LeBaluchon
//
//  Created by David Da Silva on 25/10/2021.
//

import Foundation

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
