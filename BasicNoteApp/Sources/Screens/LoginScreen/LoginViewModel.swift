//
//  LoginViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 8.08.2024.
//

import Foundation

protocol ILoginViewModel {
    func login()
    func isValidInput()
}

class LoginViewModel: ILoginViewModel {
    
    let authService = AuthService()
    
    var onSucces: ((String) -> Void)?
    var onError:((String) -> Void)?
    var isLoginButtonEnabled: ((Bool) -> Void)?
    
    var email: String = ""
    var password: String = ""
    
    func login(){
        
        let user = UserLogin(password: password, email: email)
        
        authService.login(user: user) { result in
            switch result {
            case .success(let response):
                self.onSucces?(response.data.accessToken)
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func isValidInput() {
        let isValid = !email.isEmpty && !password.isEmpty
        isLoginButtonEnabled?(isValid)
    }
}
