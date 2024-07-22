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
    @IBOutlet var errorImage: UIImageView!
    @IBOutlet var errorMessage: UILabel!
    let userService = UserService()
    var initialPassword: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        checkIsShouldEnabledSaveChangesButton()
        password.delegate = self
        new_password.delegate = self
        re_new_password.delegate = self

    }
    
    private func initialDesign() {
        password.initialDesign()
        new_password.initialDesign()
        re_new_password.initialDesign()
        errorImage.isHidden = true
        errorImage.isHidden = true
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
        initialDesign()
        
        let changePasswordStruct = ChangePassword(password: password.text!, new_password: new_password.text!, new_password_confirmation: re_new_password.text!)
        
        userService.changePassword(changePasswordStruct: changePasswordStruct) { result in
            switch result {
            case .success(let response):
                print("Password changed successfully: \(response)")
            case .failure(let error):
                self.password.showInvalidFunctionError()
                self.new_password.showInvalidFunctionError()
                self.re_new_password.showInvalidFunctionError()
                self.errorImage.isHidden = false
                self.errorMessage.text = error.localizedDescription
                self.errorMessage.isHidden = false
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
        return true // TextField'ın temizlenmesine izin vermek için true döndür
    }
}
