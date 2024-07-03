//
//  ForgotPasswordViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 3.07.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var emailAdressLabel: UITextField!
    @IBOutlet var resetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordButton.makeRadius()
        emailAdressLabel.initialDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        // reset password
        if !emailAdressLabel.isValidEmail(mail: emailAdressLabel.text ?? "") {
            emailAdressLabel.showInvalidFunctionError(message: "Your email address should contain @.")
        }
    }
    

}
