//
//  ExchangeRateViewController.swift
//  LeBaluchon
//
//  Created by David Da Silva on 16/07/2021.
//

import UIKit

class ExchangeRateViewController: UIViewController, UITextFieldDelegate{
    
    // MARK: - Outlets
    @IBOutlet weak var textFieldEuro: UITextField!
    @IBOutlet weak var labelUSD: UILabel!
    @IBOutlet weak var buttonConvertir: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Actions
    
    @IBAction func convertir(_ sender: Any) {
        if let amountToExchange = textFieldEuro.text, !amountToExchange.isEmpty {
            callExchangeRateService(amount: Decimal(string: amountToExchange)!)
        } else {
            self.presentAlert(title: "Petit problème",
                              message: "Veuillez rentrer un montant valable avant de le convertir !")
        }
    }
    
    
    
    // MARK: - Functions
    
    override func viewDidLoad(){
        super.viewDidLoad()
        labelUSD.layer.borderWidth = 1.0
        labelUSD.layer.borderColor = UIColor.black.cgColor
        buttonConvertir.layer.cornerRadius = 30
        labelUSD.layer.cornerRadius = 30
        toogleActivityIndicator(activityIndicator: self.activityIndicator,
                                button: self.buttonConvertir,
                                showActivityIndicator: false)
        
    }
    
    
    private func callExchangeRateService(amount: Decimal) {
        toogleActivityIndicator(activityIndicator: self.activityIndicator,
                                button: self.buttonConvertir,
                                showActivityIndicator: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            ExchangeRateService.shared.getExchangeRate { [weak self] success, exchangeRate in
                guard let self = self else { return }
                toogleActivityIndicator(activityIndicator: self.activityIndicator,
                                        button: self.buttonConvertir,
                                        showActivityIndicator: false)
                if success, let exchangeRate = exchangeRate {
                    self.labelUSD.text = "\(Rates.getUSDAmount(fromEuro: amount, withRate: exchangeRate.rates.usd))$"
                    
                } else {
                    self.presentAlert(title: "Petit problème",
                                      message: "Fixer n'a pas pu récupérer le taux de change.\nVeuillez réessayer.")
                }
            }
        }
    }
    
    
    // MARK: - Functions Config
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textFieldEuro.resignFirstResponder()
    }
}


