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
    
    func showInvalidFunctionError(message: String) {
        
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        
        // Yeni bir view oluşturma
        let containerView = UIView()
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        
        // Yeni bir UIImageView (ikon) oluşturma
        let iconView = UIImageView()
        iconView.image = UIImage(named: "erroricon") // Simgesini belirleyin
        iconView.tintColor = UIColor.red
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Yeni bir UILabel oluşturma
        let errorText = UILabel()
        errorText.text = message
        errorText.textColor = UIColor.red
        errorText.font = UIFont.systemFont(ofSize: 12)
        errorText.translatesAutoresizingMaskIntoConstraints = false
        
        // iconView ve errorText'i containerView'in içine ekleyin
        containerView.addSubview(iconView)
        containerView.addSubview(errorText)
        
        // containerView'i parent view'in içine ekleyin
        if let parentView = self.superview {
            parentView.addSubview(containerView)
            
            // Auto Layout kullanarak containerView'in konumunu ayarlayın
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
                containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                containerView.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            // Auto Layout kullanarak iconView'in ve errorText'in konumunu ayarlayın
            NSLayoutConstraint.activate([
                iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                iconView.widthAnchor.constraint(equalToConstant: 16),
                iconView.heightAnchor.constraint(equalToConstant: 16),
                
                errorText.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
                errorText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                errorText.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
        }
    }
}
