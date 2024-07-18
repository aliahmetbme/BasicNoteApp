//
//  ViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet private var fullNameLabel: UITextField!
    @IBOutlet private var emailAdressLabel: UITextField!
    @IBOutlet private var passwordLabel: UITextField!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalDesign()
    }
    
    private func initalDesign () {
        
        fullNameLabel.initialDesign()
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        registerButton.disabledDesign()

        loginButton.setAttributedTitle(part1: "Already have Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
    
        setBackButtonItemTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

// Actions
extension RegisterViewController {
    
    @IBAction private func register(_ sender: Any) {
        passwordLabel.showInvalidFunctionError(message: "Password Invalid")
        print(emailAdressLabel.isValidEmail(email: emailAdressLabel.text!))
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
        print(emailAdressLabel.isValidEmail(email: emailAdressLabel.text!))

    }
}
