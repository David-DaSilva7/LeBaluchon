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
   
    
    override func viewDidLoad() {
            super.viewDidLoad()
        labelUSD.layer.borderWidth = 1.0
        labelUSD.layer.borderColor = UIColor.black.cgColor
        buttonConvertir.layer.cornerRadius = 30
        labelUSD.layer.cornerRadius = 30
    }
    
        func callExchangeRateService(amount: Decimal) {
            ExchangeRateService.shared.getExchangeRate { [weak self] success, exchangeRate in
                guard let self = self else { return }
                
                if success, let exchangeRate = exchangeRate {
                    self.labelUSD.text = "\(Rates.getUSDAmount(fromEuro: amount, withRate: exchangeRate.rates.usd))$"
                    
                } else {
                    self.presentAlert(title: "Petit problème",
                                      message: "Fixer n'a pas pu récupérer le taux de change.\nVeuillez réessayer.")
                }
            }
            // Do any additional setup after loading the view.
        }
 
    @IBAction func convertir(_ sender: Any) {
        
        if let amountToExchange = textFieldEuro.text, !amountToExchange.isEmpty {
            callExchangeRateService(amount: Decimal(string: amountToExchange)!)
        } else {
            self.presentAlert(title: "Petit problème",
                              message: "Fixer n'a pas pu récupérer le taux de change.\nVeuillez réessayer.")
        }
    }
    
    

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textFieldEuro.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }



//    func textField(_ textField: UITextField,
//                   shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool {
//        // Limit the textfield entry to two decimal
//        guard let oldText = textField.text, let range = Range(range, in: oldText) else {
//            return true
//        }
//
//        let newText = oldText.replacingCharacters(in: range, with: string)
//        let isNumeric = newText.isEmpty || (Double(newText) != nil)
//        let numberOfDots = newText.components(separatedBy: ".").count - 1
//
//        let numberOfDecimalDigits: Int
//        if let dotIndex = newText.firstIndex(of: ".") {
//            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
//        } else {
//            numberOfDecimalDigits = 0
//        }
//
//        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
//    }

}


