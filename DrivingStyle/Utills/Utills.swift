//
//  Utills.swift
//  DrivingStyle
//
//  Created by Neskin Ivan on 24.01.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import UIKit


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UITextField {
    class func setupTextfield(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = UIColor(white: 0, alpha: 0.04)
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "Helvetica Neue", size: 15.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }
        
}
