//
//  ViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet private var fullNameLabel: UITextField!
    @IBOutlet private var emailAdressLabel: UITextField!
    @IBOutlet private var passwordLabel: UITextField!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var loginButton: UIButton!
    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalDesign()
    }
    
    private func initalDesign () {
        
        fullNameLabel.initialDesign()
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        registerButton.disabledDesign()
        setBackButtonTitle()
        loginButton.setAttributedTitle(part1: "Already have Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

// Actions
extension RegisterViewController {
    
    @IBAction private func register(_ sender: Any) {
        let user = UserRegister(password: passwordLabel.text! , email: emailAdressLabel.text! , full_name: fullNameLabel.text!)
        
        authService.register(user: user) { result in
            switch result {
            case .success(let response):
                print(response)
                self.performSegue(withIdentifier: "goLoginPage", sender: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
        print(emailAdressLabel.isValidEmail(email: emailAdressLabel.text!))

    }
}
