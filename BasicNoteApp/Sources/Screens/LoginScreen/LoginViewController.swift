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
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var errorImage: UIImageView!
       
    private let auhtService = AuthService()
    private var loginSucces: ((String) -> Void)?
    private var loginError:((Error) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        initialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialDesign()
        initialSettings()
    }
    
    private func initialDesign() {
        goRegisterPageButton.setAttributedTitle(part1: "New User? ", color1: UIColor.black, part2: "Sign up now", color2: UIColor.signuptext, for: .normal)
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        setBackButtonTitle()
        errorMessage.isHidden = true
        errorImage.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func initialSettings() {
        loginSucces = {token in
            UserDefaults.standard.setValue(token, forKey: "accesToken")
            self.performSegue(withIdentifier: "goNotesPage", sender: nil)
        }
        
        loginError = { error in
            print(error.localizedDescription)
        }
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
        initialDesign()
        
        let user = UserLogin(password: passwordLabel.text!, email: emailAdressLabel.text!)
        
        auhtService.login(user: user) { result in
            switch result {
            case .success(let response):
                self.loginSucces?(response.data.accessToken)
            case .failure(let error):
                self.emailAdressLabel.showInvalidFunctionError()
                self.passwordLabel.showInvalidFunctionError()
                self.errorMessage.text = error.localizedDescription
                self.errorMessage.isHidden = false
                self.errorImage.isHidden = false
            }
        }
    }
}
