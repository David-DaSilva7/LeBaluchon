//
//  ExchangeRate.swift
//  LeBaluchon
//
//  Created by David Da Silva on 18/08/2021.
//

import Foundation

class ExchangeRate {
    static let shared = ExchangeRate()
    private init() {}
    private let exchangeRateUrl = "https://data.fixer.io/api/latest"
    private var task: URLSessionDataTask?

    
    func getExchangeRate(callback: @escaping (Bool, Data?) -> Void) {
        let session = URLSession(configuration: .default)

        guard let url = URL(string: exchangeRateUrl) else {
            callback(false, nil)
            return
        }

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }

                callback(true, data)
            }
        }
        task?.resume()
    }
}
