//
//  ViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet private var FullNameField: UITextField!
    @IBOutlet private var EmailAdressField: UITextField!
    @IBOutlet private var PasswordField: UITextField!
    @IBOutlet private var RegisterButton: UIButton!
    @IBOutlet private var LoginButton: UIButton!
    @IBOutlet var ErrorMessage: UILabel!
    @IBOutlet var ErrorImage: UIImageView!
    
    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalDesign()
    }
    override func viewWillAppear(_ animated: Bool) {
        initalDesign()
    }
    private func initalDesign() {
        FullNameField.initialDesign()
        EmailAdressField.initialDesign()
        PasswordField.initialDesign()
        RegisterButton.disabledDesign()
        setBackButtonTitle()
        self.ErrorImage.isHidden = true
        self.ErrorMessage.isHidden = true
        LoginButton.setAttributedTitle(part1: "Already have Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
    }
}

// Actions
extension RegisterViewController {
    
    @IBAction private func register(_ sender: Any) {
        initalDesign()
        let user = UserRegister(password: PasswordField.text! , email: EmailAdressField.text! , full_name: FullNameField.text!)
        
        authService.register(user: user) { result in
            switch result {
            case .success(let response):
                print(response)
                self.performSegue(withIdentifier: "goLoginPage", sender: nil)
            case .failure(let error):
                self.EmailAdressField.showInvalidFunctionError()
                self.FullNameField.showInvalidFunctionError()
                self.PasswordField.showInvalidFunctionError()
                self.ErrorImage.isHidden = false
                self.ErrorMessage.text = error.localizedDescription
                self.ErrorMessage.isHidden = false
            }
        }
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
        print(EmailAdressField.isValidEmail(email: EmailAdressField.text!))

    }
}
