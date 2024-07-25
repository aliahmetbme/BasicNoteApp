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
    let userService = UserService()
    var initialPassword: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        checkIsShouldEnabledSaveChangesButton()
        Password.delegate = self
        NewPassword.delegate = self
        ReNewPassword.delegate = self

    }
    
    private func initialDesign() {
        Password.initialDesign()
        NewPassword.initialDesign()
        ReNewPassword.initialDesign()
        ErrorImage.isHidden = true
        ErrorImage.isHidden = true
    }
    
    
    private func checkIsShouldEnabledSaveChangesButton () {
        if (Password.text == "" || NewPassword.text == "" || ReNewPassword.text == "") {
            SaveButton.isEnabled = false
            SaveButton.disabledDesign()
        } else {
            SaveButton.isEnabled = true

        }
    }

}

// Actions
extension PasswordChangeScreenViewController {
    @IBAction private func changePassword(_ sender: Any) {
        initialDesign()
        
        let changePasswordStruct = ChangePassword(password: Password.text!, newPassword: NewPassword.text!, newPasswordConfirmation: ReNewPassword.text!)
        
        userService.changePassword(changePasswordStruct: changePasswordStruct) { result in
            switch result {
            case .success(let response):
                print("Password changed successfully: \(response)")
            case .failure(let error):
                self.Password.showInvalidFunctionError()
                self.NewPassword.showInvalidFunctionError()
                self.ReNewPassword.showInvalidFunctionError()
                self.ErrorImage.isHidden = false
                self.ErrorMessage.text = error.localizedDescription
                self.ErrorMessage.isHidden = false
            }
        }
    }
    
    @IBAction private func turnBack() {
        navigationController?.popViewController(animated: true)
    }
}

// TextView Delegates
extension PasswordChangeScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkIsShouldEnabledSaveChangesButton()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        checkIsShouldEnabledSaveChangesButton()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        checkIsShouldEnabledSaveChangesButton()
        return true
    }
}
