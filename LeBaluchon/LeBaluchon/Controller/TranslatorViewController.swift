//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by David Da Silva on 16/07/2021.
//

import UIKit

class TranslatorViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var textToTranslate: UITextView!
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
        
        if let textToTranslate = textToTranslate.text, !textToTranslate.isEmpty {
            translation(with: textToTranslate)
        } else {
            self.presentAlert(title: "Petit problème",
                              message: "Veuillez rentrer un texte valable avant de le traduire !")
        }
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textToTranslate.resignFirstResponder()
    }
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        textToTranslate.text = "Entrez du texte"
        self.labelConfig()
        self.textToTranslateTextView()
        toogleActivityIndicator(activityIndicator: self.activityIndicator,
                                button: self.buttonTranslate,
                                showActivityIndicator: false)
    }
    
    
    private func translation(with textToTranslate: String) {
        toogleActivityIndicator(activityIndicator: self.activityIndicator,
                                button: self.buttonTranslate,
                                showActivityIndicator: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            TranslatorService.shared.getTranslation(with: textToTranslate) { [weak self] success, translatedText in
                guard let self = self else { return }
                toogleActivityIndicator(activityIndicator: self.activityIndicator,
                                        button: self.buttonTranslate,
                                        showActivityIndicator: false)
                if success, let translatedText = translatedText {
                    self.update(translationText: translatedText)
                } else {
                    self.presentAlert(title: "Petit problème",
                                      message: "Google traduction n'a pas répondu.\nVeuillez réessayer.")
                }
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
            if textToTranslate.text == "" || textToTranslate.text == "Entrez du texte" {
                textToTranslate.text = "Enter text"
            }
        } else {
            Languages.sourceLanguageCodeISO = "fr"
            Languages.targetLanguageCodeISO = "en"
            self.firstLabel.text = "Français"
            self.secondLabel.text = "Anglais"
            if textToTranslate.text == "" || textToTranslate.text == "Enter text" {
                textToTranslate.text = "Entrez du texte"
            }
        }
    }
    
    // MARK: - Functions Config
    private func labelConfig(){
        translatedLabel.textAlignment = .left
        translatedLabel.layer.borderWidth = 1.0
        translatedLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    private func textToTranslateTextView(){
        textToTranslate.textAlignment = .left
        textToTranslate.layer.borderWidth = 1.0
        textToTranslate.layer.borderColor = UIColor.black.cgColor
    }
}
