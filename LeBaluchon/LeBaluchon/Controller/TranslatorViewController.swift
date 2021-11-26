//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by David Da Silva on 16/07/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var firstTextfield: UITextField!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var translatedLabel: UITextView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonTranslate: UIButton!
    
    // MARK: - Actions
    @IBAction func switchLanguage(_ sender: UIButton) {
        switchLanguage()
    }
    
    @IBAction func translate(_ sender: UIButton) {
        
        if let textToTranslate = firstTextfield.text, !textToTranslate.isEmpty {
            translation(with: textToTranslate)
        } else {
            self.presentAlert(title: "Petit problème",
                              message: "Veuillez rentrer un texte valable avant de le traduire !")
        }
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        firstTextfield.resignFirstResponder()
    }
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldConfig()
        self.labelConfig()
        toogleActivityIndicator(show: true)
    }
    
    
    private func translation(with textToTranslate: String) {
        toogleActivityIndicator(show: false)
        TranslatorService.shared.getTranslation(with: textToTranslate) { [weak self] success, translatedText in
            guard let self = self else { return }
            self.toogleActivityIndicator(show: true)
            if success, let translatedText = translatedText {
                self.update(translationText: translatedText)
            } else {
                self.presentAlert(title: "Petit problème",
                                  message: "Google traduction n'a pas répondu.\nVeuillez réessayer.")
            }
        }
    }
    
    
    private func update(translationText: String) {
        translatedLabel.text = translationText
    }
    
    
    func switchLanguage(){
        if Languages.sourceLanguageCodeISO == "fr" {
            Languages.sourceLanguageCodeISO = "en"
            Languages.targetLanguageCodeISO = "fr"
            self.firstLabel.text = "Anglais"
            self.secondLabel.text = "Français"
            
        } else {
            Languages.sourceLanguageCodeISO = "fr"
            Languages.targetLanguageCodeISO = "en"
            self.firstLabel.text = "Français"
            self.secondLabel.text = "Anglais"
            
        }
    }
    
    // MARK: - Functions Config
    
    private func textFieldConfig() {
        firstTextfield.textAlignment = .left
        firstTextfield.contentVerticalAlignment = .top
    }
    
    private func labelConfig(){
        translatedLabel.textAlignment = .left
        translatedLabel.layer.borderWidth = 1.0
        translatedLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstTextfield.resignFirstResponder()
        return true
    }
    
    private func toogleActivityIndicator(show: Bool){
        activityIndicator.isHidden = show
        buttonTranslate.isHidden = !show
    }
}
