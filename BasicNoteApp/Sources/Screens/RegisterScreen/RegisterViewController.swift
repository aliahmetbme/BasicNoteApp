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
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var errorImage: UIImageView!
    
    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalDesign()
    }
    
    private func initalDesign () {
        navigationController?.isNavigationBarHidden = true
        fullNameLabel.initialDesign()
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        registerButton.disabledDesign()
        setBackButtonTitle()
        self.errorImage.isHidden = true
        self.errorMessage.isHidden = true
        loginButton.setAttributedTitle(part1: "Already have Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

// Actions
extension RegisterViewController {
    
    @IBAction private func register(_ sender: Any) {
        initalDesign()
        let user = UserRegister(password: passwordLabel.text! , email: emailAdressLabel.text! , full_name: fullNameLabel.text!)
        
        authService.register(user: user) { result in
            switch result {
            case .success(let response):
                print(response)
                self.performSegue(withIdentifier: "goLoginPage", sender: nil)
            case .failure(let error):
                self.emailAdressLabel.showInvalidFunctionError()
                self.fullNameLabel.showInvalidFunctionError()
                self.passwordLabel.showInvalidFunctionError()
                self.errorImage.isHidden = false
                self.errorMessage.text = error.localizedDescription
                self.errorMessage.isHidden = false
            }
        }
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
        print(emailAdressLabel.isValidEmail(email: emailAdressLabel.text!))

    }
}
