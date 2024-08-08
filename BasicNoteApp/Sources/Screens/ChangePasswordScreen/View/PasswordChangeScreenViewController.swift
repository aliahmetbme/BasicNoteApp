//
//  PasswordChangeScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit

class PasswordChangeScreenViewController: UIViewController {
    
    @IBOutlet var Password: UITextField!
    @IBOutlet var NewPassword: UITextField!
    @IBOutlet var ReNewPassword: UITextField!
    @IBOutlet var SaveButton: UIButton!
    @IBOutlet var ErrorImage: UIImageView!
    @IBOutlet var ErrorMessage: UILabel!
    
    private var viewModel = PasswordChangeViewModel()
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        initialSettings()
        setupBindings()
    }
    
    private func initialSettings() {
        Password.delegate = self
        NewPassword.delegate = self
        ReNewPassword.delegate = self
    }
    
    private func initialDesign() {
        Password.initialDesign()
        NewPassword.initialDesign()
        ReNewPassword.initialDesign()
        
        ErrorImage.isHidden = true
        ErrorMessage.isHidden = true
        SaveButton.isEnabled = false
        
    }
    
    private func setupBindings() {
        viewModel.onSuccesPasswordChange = { [weak self] message in
            self?.showToast(message: message, isSuccess: true)
        }
        
        viewModel.onErrorPasswordChange = { [weak self] message in
            self?.ErrorMessage.text = message
            self?.ErrorMessage.isHidden = false
            self?.ErrorImage.isHidden = false
        }
        
        viewModel.isSaveButtonEnabled = { [weak self] isEnabled in
            self?.SaveButton.isEnabled = isEnabled
            isEnabled ? self?.SaveButton.enableDesign() : self?.SaveButton.disabledDesign()
        }
    }
}

// Actions
extension PasswordChangeScreenViewController {
    @IBAction private func changePassword(_ sender: Any) {
        initialDesign()
        viewModel.changePassword()
    }
    
    @IBAction private func turnBack() {
        navigationController?.popViewController(animated: true)
    }
}

// TextView Delegates
extension PasswordChangeScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.validateInputs()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.validateInputs()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        updateViewModel(textField: textField)
        viewModel.validateInputs()
        return true
    }
    
    private func updateViewModel(textField: UITextField) {
        if textField == Password {
            viewModel.password = textField.text ?? ""
        } else if textField == NewPassword {
            viewModel.newPassword = textField.text ?? ""
        } else if textField == ReNewPassword {
            viewModel.reNewPassword = textField.text ?? ""
        }
    }
}
