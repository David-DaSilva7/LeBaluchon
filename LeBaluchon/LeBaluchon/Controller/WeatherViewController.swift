//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by David Da Silva on 16/07/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var metzDescriptionLabel: UILabel!
    @IBOutlet weak var metzTemperatureLabel: UILabel!
    @IBOutlet weak var metzHumidityLabel: UILabel!
    @IBOutlet weak var newYorkDescriptionLabel: UILabel!
    @IBOutlet weak var newYorkTemperatureLabel: UILabel!
    @IBOutlet weak var newYorkHumidityLabel: UILabel!
    
    // MARK: - Functions
    
    //    override func viewDidLoad() {
//        super.viewDidLoad()
//        callWeatherService(for: .paris)
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callWeatherService(for: .metz)
    }
    
    
    private func callWeatherService(for city: Cities) {
        WeatherService.shared.getWeather(for: city) { [weak self] success, weather in
            guard let self = self else { return }

            if success, let weather = weather {
                if city == .metz {
                    self.metzDescriptionLabel.text = weather.weather[0].weatherDescription.capitalizingFirstLetter()
                    self.metzTemperatureLabel.text = "\(Int(weather.main.temp))°C"
                    self.metzHumidityLabel.text = "Humidité : \(weather.main.humidity)%"
                    self.callWeatherService(for: .newYork)
                } else {
                    self.newYorkDescriptionLabel.text = weather.weather[0].weatherDescription.capitalizingFirstLetter()
                    self.newYorkTemperatureLabel.text = "\(Int(weather.main.temp))°C"
                    self.newYorkHumidityLabel.text = "Humidité : \(weather.main.humidity)%"
                }
            } else {
                self.presentAlert(title: "Petit problème",
                                  message: "OpenWeather n'a pas répondu.\nVeuillez réessayer.")
            }
        }
    }
}
