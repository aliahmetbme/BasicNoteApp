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
    @IBOutlet private var LoginButton: UIButton!
    @IBOutlet private var errorMessage: UILabel!
    @IBOutlet private var errorImage: UIImageView!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialDesign()
        setupBinding()
    }
    
    private func initialDesign() {
        goRegisterPageButton.setAttributedTitle(part1: "New User? ", color1: UIColor.black, part2: "Sign up now", color2: UIColor.signuptext, for: .normal)
        
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        
        emailAdressLabel.delegate = self
        passwordLabel.delegate = self
        
        
        setBackButtonTitle()
        
        errorMessage.isHidden = true
        errorImage.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupBinding() {
        
        viewModel.isValidInput()
        
        viewModel.isLoginButtonEnabled = { isEnabled in
            self.LoginButton.isEnabled = isEnabled
            isEnabled ? self.LoginButton.enableDesign() : self.LoginButton.disabledDesign()
        }
        
        viewModel.onSucces = {token in
            // bunu sor modelde mi kalmalı yoksa burda mı ?
            UserDefaults.standard.setValue(token, forKey: "accesToken")
            self.performSegue(withIdentifier: "goNotesPage", sender: nil)
        }
        
        viewModel.onError = { error in
            self.errorMessage.text = error
            self.errorMessage.isHidden = false
            self.errorImage.isHidden = false
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
        viewModel.login()
    }
}

// UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.isValidInput()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.isValidInput()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        updateViewModel(textField: textField)
        viewModel.isValidInput()
        return true
    }
    
    private func updateViewModel(textField: UITextField) {
        switch textField {
        case self.emailAdressLabel:
            viewModel.email = textField.text ?? ""
        case self.passwordLabel:
            viewModel.password = textField.text ?? ""
        default:
            break
        }
    }
}
