//
//  ExchangeRate.swift
//  LeBaluchon
//
//  Created by David Da Silva on 18/08/2021.
//

import Foundation

class ExchangeRateService {
    

    
    // MARK: - Properties
    static let shared = ExchangeRateService()
    private init() {}
    private var task: URLSessionDataTask?
    
    // MARK: - Function
    func getExchangeRate(callback: @escaping (Bool, ExchangeRate?) -> Void) {
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: FixerExchangeRate.url) else {
            callback(false, nil)
            return
        }
        
        task?.cancel()
        task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}


