//
//  Indicator.swift
//  LeBaluchon
//
//  Created by David Da Silva on 29/11/2021.
//

import UIKit



func toogleActivityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
    activityIndicator.isHidden = !showActivityIndicator
    button.isHidden = showActivityIndicator
}
