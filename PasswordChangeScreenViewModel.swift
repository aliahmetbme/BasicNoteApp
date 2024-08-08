//
//  PasswordChangeScreenViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 7.08.2024.
//

import Foundation
import UIKit

protocol IPasswordChangeViewModel {
    func validateInputs()
    func changePassword()
}

class PasswordChangeViewModel: IPasswordChangeViewModel {
    let userService = UserService()
    
    var password: String = ""
    var newPassword: String = ""
    var reNewPassword: String = ""
        
    var onErrorPasswordChange: ((String) -> Void)?
    var onSuccesPasswordChange: ((String) -> Void)?

    var isSaveButtonEnabled: ((Bool) -> Void)?
    
    func changePassword() {
        let changePasswordStruct = ChangePassword(password: password, newPassword: newPassword, newPasswordConfirmation: reNewPassword)
        
        print(changePasswordStruct)
        
        userService.changePassword(changePasswordStruct: changePasswordStruct) { result in
            switch result {
            case .success(let response):
                    self.onSuccesPasswordChange?(response.message)
            case .failure(let error):
                    self.onErrorPasswordChange?(error.message)
            }
        }
    }
    
    func validateInputs() {
        let isValid = !password.isEmpty && !newPassword.isEmpty && !reNewPassword.isEmpty
        isSaveButtonEnabled?(isValid)
    }
}
