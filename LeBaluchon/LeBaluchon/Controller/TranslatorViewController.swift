//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by David Da Silva on 16/07/2021.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    @IBOutlet weak var frTextfield: UITextField!
    private var sourceLanguage = "fr"
    private var targetLanguage = "en"
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBAction func switchLanguage(_ sender: Any) {
        switchLanguage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldConfig()
        
        // Do any additional setup after loading the view.
    }
    
    private func textFieldConfig() {
        frTextfield.textAlignment = .left
        frTextfield.contentVerticalAlignment = .top
    }
    
    func switchLanguage(){
        if sourceLanguage == "fr" {
            sourceLanguage = "en"
            self.firstLabel.text = "Anglais"
            self.secondLabel.text = "Français"
            
        } else {
            sourceLanguage = "fr"
            self.firstLabel.text = "Français"
            self.secondLabel.text = "Anglais"
            
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
