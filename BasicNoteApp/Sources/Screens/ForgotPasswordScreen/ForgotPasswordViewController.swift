//
//  ForgotPasswordViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 3.07.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet private var emailAdressLabel: UITextField!
    @IBOutlet private var resetPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordButton.makeRadius()
        emailAdressLabel.initialDesign()
        setBackButtonTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

// Actions
extension ForgotPasswordViewController {
    
    @IBAction private func resetPassword(_ sender: Any) {
        // reset password
        if !emailAdressLabel.isValidEmail(email: emailAdressLabel.text!) {
            emailAdressLabel.showInvalidFunctionError()
        }
    }
}
