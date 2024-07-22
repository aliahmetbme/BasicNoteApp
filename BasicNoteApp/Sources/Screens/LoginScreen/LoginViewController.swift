//
//  LoginViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 2.07.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private var emailAdressLabel: UITextField!
    @IBOutlet private var passwordLabel: UITextField!
    @IBOutlet private var goRegisterPageButton: UIButton!
    private let auhtService = AuthService()
    var loginSucces: ((String) -> Void)?
    var loginError:((Error) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goRegisterPageButton.setAttributedTitle(part1: "New User? ", color1: UIColor.black, part2: "Sign up now", color2: UIColor.signuptext, for: .normal)
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        setBackButtonTitle(isHideNavBar: false)  // Corrected method name
        
        loginSucces = {token in
            UserDefaults.standard.setValue(token, forKey: "accesToken")
            self.performSegue(withIdentifier: "goNotesPage", sender: nil)
        }
        
        loginError = { error in
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // Added this line for completeness
        navigationController?.isNavigationBarHidden = false
    }
}

// Actions
extension LoginViewController {
    @IBAction private func goRegisterPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func forgotPassword(_ sender: Any) {
        performSegue(withIdentifier: "goForgorVC", sender: nil)
    }
    
    @IBAction private func login(_ sender: Any) {
        let user = UserLogin(password: passwordLabel.text!, email: emailAdressLabel.text!)
        
        auhtService.login(user: user) { result in
            switch result {
            case .success(let response):
                self.loginSucces?(response.data.accessToken)
            case .failure(let error):
                self.loginError?(error)
            }
        }
    }
}
