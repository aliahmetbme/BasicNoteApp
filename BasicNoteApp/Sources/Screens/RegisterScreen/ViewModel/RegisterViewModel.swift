//
//  RegisterViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 7.08.2024.
//

import Foundation

protocol IRegisterViewModel {
    func register()
    func isValidInputs()
}

class RegisterViewModel: IRegisterViewModel {

    var isRegisterButtonEnabled: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    let authService = AuthService()
    
    var password: String = ""
    var fullName: String = ""
    var email: String = ""
    
    func register() {
        let user = UserRegister(password: password, email: email, fullName: fullName)
        
        authService.register(user: user) { result in
            switch result {
            case .success(_):
                self.onSuccess!()
            case .failure(let error):
                self.onError!(error.localizedDescription)
            }
        }
    }
    
    func isValidInputs() {
        let isValid = !password.isEmpty && !fullName.isEmpty && !email.isEmpty
        isRegisterButtonEnabled?(isValid)
    }
}
