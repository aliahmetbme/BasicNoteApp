//
//  Extensions@+UITextField.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 9.07.2024.
//

import Foundation
import UIKit


extension UITextField {
    
    // default değerler
    func initialDesign(radius:CGFloat = 5, borderWidth:CGFloat = 1, width:CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        
    }
    // Regex kullan
    func isValidEmail (email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func showInvalidFunctionError() {
        self.layer.borderColor = UIColor(named: "errorColor")?.cgColor
        self.layer.borderWidth = 1

    }
}
