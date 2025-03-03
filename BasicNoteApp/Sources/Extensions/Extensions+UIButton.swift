//
//  Extensions@+UIButton.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 9.07.2024.
//

import Foundation
import UIKit


extension UIButton {
    func makeRadius (cornerRadius: CGFloat = 5) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func initialDesign() {
        if (!self.isEnabled) {
            self.backgroundColor = UIColor(named: "buttonLoginDisabled")
            self.setTitleColor(UIColor.signuptext, for: .normal)
        } else {
            self.backgroundColor = UIColor.signuptext
            self.setTitleColor(UIColor.white, for: .normal)
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
