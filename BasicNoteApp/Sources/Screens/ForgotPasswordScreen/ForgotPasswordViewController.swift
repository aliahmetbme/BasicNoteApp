//
//  ForgotPasswordViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 3.07.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet private var EmailAdressLabel: UITextField!
    @IBOutlet private var ResetPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
    }

    override func viewWillAppear(_ animated: Bool) {
        initialDesign()
    }
    
    private func initialDesign() {
        ResetPasswordButton.makeRadius()
        EmailAdressLabel.initialDesign()
        setBackButtonTitle(isHideNavBar: false)
    }
}

// Actions
extension ForgotPasswordViewController {
    
    @IBAction private func resetPassword(_ sender: Any) {
        // reset password
        if !EmailAdressLabel.isValidEmail(email: EmailAdressLabel.text!) {
            EmailAdressLabel.showInvalidFunctionError()
        }
    }
}
