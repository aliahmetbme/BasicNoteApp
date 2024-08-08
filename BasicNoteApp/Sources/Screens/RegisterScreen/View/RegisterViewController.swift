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
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        initalDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBinding()
        initalDesign()
    }
    
    private func setupBinding() {

        viewModel.isValidInputs()
        
        viewModel.isRegisterButtonEnabled = { isEnabled in
            self.RegisterButton.isEnabled = isEnabled
            isEnabled ? self.RegisterButton.enableDesign() : self.RegisterButton.disabledDesign()
        }
        
        viewModel.onError = { errorMessage in
            self.ErrorMessage.text = errorMessage
            self.ErrorImage.isHidden = false
            self.ErrorMessage.isHidden = false
        }
        
        viewModel.onSuccess = {
            self.performSegue(withIdentifier: "goLoginPage", sender: nil)
        }
    }
    
    

    private func initalDesign() {
        FullNameField.initialDesign()
        EmailAdressField.initialDesign()
        PasswordField.initialDesign()
        
        FullNameField.delegate = self
        EmailAdressField.delegate = self
        PasswordField.delegate = self
        
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
        viewModel.register()
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
    }
}

// UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateViewModel(from: textField)
        viewModel.isValidInputs()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateViewModel(from: textField)
        viewModel.isValidInputs()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        updateViewModel(from: textField)
        viewModel.isValidInputs()
        return true
    }
    
    private func updateViewModel(from textField: UITextField) {
        switch textField {
        case FullNameField:
            viewModel.fullName = textField.text ?? ""
        case EmailAdressField:
            viewModel.email = textField.text ?? ""
        case PasswordField:
            viewModel.password = textField.text ?? ""
        default:
            break
        }
    }
}
