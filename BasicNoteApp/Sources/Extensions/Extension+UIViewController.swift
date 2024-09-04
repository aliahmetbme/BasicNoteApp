//
//  Extension+UIViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func setBackButtonTitle(title: String = "", isHideNavBar: Bool = true) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.title = title
        navigationController?.setNavigationBarHidden(isHideNavBar, animated: true)
    }
    
    func showToast(message: String, isSuccess: Bool, duration: Double = 3.0) {
           // Toast label setup
           let toastLabel = UILabel()
           toastLabel.backgroundColor = isSuccess ? UIColor.systemGreen : UIColor.systemRed
           toastLabel.textColor = UIColor.white
           toastLabel.textAlignment = .center
           toastLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
           toastLabel.text = message
           toastLabel.numberOfLines = 0
           toastLabel.alpha = 0.0
           toastLabel.layer.cornerRadius = 15
           toastLabel.layer.masksToBounds = true
           toastLabel.layer.shadowColor = UIColor.black.cgColor
           toastLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
           toastLabel.layer.shadowOpacity = 0.3
           toastLabel.layer.shadowRadius = 4

           // Auto Layout Constraints
           toastLabel.translatesAutoresizingMaskIntoConstraints = false
           self.view.addSubview(toastLabel)
           
           // Center the toast label horizontally and set a top margin
           NSLayoutConstraint.activate([
               toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               toastLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
               toastLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
               toastLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
           ])
           
           // Animations
           UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
               toastLabel.alpha = 1.0
               toastLabel.transform = CGAffineTransform(translationX: 0, y: 20)
           }, completion: { _ in
               UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseInOut, animations: {
                   toastLabel.alpha = 0.0
                   toastLabel.transform = CGAffineTransform(translationX: 0, y: 40)
               }, completion: { _ in
                   toastLabel.removeFromSuperview()
               })
           })
    }
}
