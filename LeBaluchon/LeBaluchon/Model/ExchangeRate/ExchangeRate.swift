//
//  ExchangeRate.swift
//  LeBaluchon
//
//  Created by David Da Silva on 18/10/2021.
//

import Foundation



// Reflect the Fixer exchange rate API response body JSON structure to decode Fixer response
// MARK: - ExchangeRate
struct ExchangeRate: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: Rates
}

// MARK: - Rates
struct Rates: Codable {
    let usd: Decimal
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
    
    static func getUSDAmount(fromEuro amount: Decimal, withRate usd: Decimal) -> Decimal {
        var amountInUSD = amount * usd 
        var amountInUSDrounded: Decimal = Decimal()
        NSDecimalRound(&amountInUSDrounded, &amountInUSD, 2, .plain)
        return amountInUSDrounded
    }
}