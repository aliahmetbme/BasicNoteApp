//
//  PasswordChangeScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit

class PasswordChangeScreenViewController: UIViewController {

    @IBOutlet var password: UITextField!
    @IBOutlet var new_password: UITextField!
    @IBOutlet var re_new_password: UITextField!
    @IBOutlet var saveButton: UIButton!
    let userService = UserService()
    var initialPassword: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIsShouldEnabledSaveChangesButton()
        password.delegate = self
        new_password.delegate = self
        re_new_password.delegate = self

    }
    
    private func checkIsShouldEnabledSaveChangesButton () {
        if (password.text == "" || new_password.text == "" || re_new_password.text == "") {
            saveButton.isEnabled = false
            saveButton.disabledDesign()
        } else {
            saveButton.isEnabled = true

        }
    }

}

// Actions
extension PasswordChangeScreenViewController {
    @IBAction private func changePassword(_ sender: Any) {
        let changePasswordStruct = ChangePassword(password: password.text!, new_password: new_password.text!, new_password_confirmation: re_new_password.text!)
        
        if passwordMatchCheck(password: new_password, rePassword: re_new_password) {
            userService.changePassword(changePasswordStruct: changePasswordStruct) { result in
                switch result {
                case .success(let response):
                    print("Password changed successfully: \(response)")
                case .failure(let error):
                    print("Error occurred: \(error.localizedDescription)")
                }
            }
        }  else {
            new_password.showInvalidFunctionError(message: "Password must match")
            re_new_password.showInvalidFunctionError(message: "Password must match")
        }
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
        return true // TextField'ın temizlenmesine izin vermek için true döndür
    }
}
