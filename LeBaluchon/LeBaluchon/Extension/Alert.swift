//
//  Alert.swift
//  LeBaluchon
//
//  Created by David Da Silva on 25/10/2021.
//

import UIKit

extension UIViewController {
    /**
     - Parameters:
     - title: The alert's title
     - message: The error message to be displayed
     */
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

