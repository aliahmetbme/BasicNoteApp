//
//  Extensions.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 2.07.2024.
//

import Foundation
import UIKit

extension UITextField {
    
    
    
    func initialDesign() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        
    }
    
    func showInvalidFunctionError() {
        
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
        errorText.text = "Password Invalid"
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

extension UIButton {
    func makeRadius () {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func disabledDesign() {
        if (!self.isEnabled) {
            self.backgroundColor = UIColor(named: "buttonLoginDisabled")
            self.setTitleColor(UIColor.textPrimary, for: .normal)
        }
    }
    
    func setAttributedTitle(part1: String, color1: UIColor, part2: String, color2: UIColor, for state: UIControl.State) {
        let attributes1: [NSAttributedString.Key: Any] = [
            .foregroundColor: color1
        ]
        
        let attributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: color2
        ]
        
        let attributedString = NSMutableAttributedString(string: part1, attributes: attributes1)
        let part2AttributedString = NSAttributedString(string: part2, attributes: attributes2)
        
        attributedString.append(part2AttributedString)
        
        self.setAttributedTitle(attributedString, for: state)
    }
}
