//
//  ForgetPasswordViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 8.08.2024.
//

import Foundation

protocol IForgotPasswordViewModel {
    func resetPassword()
}

class ForgetPasswordViewModel: IForgotPasswordViewModel {
    
    private let authService = AuthService()
    
    var email = ""
    var onSuccesfullySenginForhgetRequest:((String) -> Void)?
    var onErrorSenginForhgetRequest:((String) -> Void)?
    
    func resetPassword() {
        authService.forgotPassword(email: email) { result in
            switch result {
            case .success(let response):
                self.onSuccesfullySenginForhgetRequest?(response.message)
            case .failure(let error):
                self.onErrorSenginForhgetRequest?(error.localizedDescription)
            }
        }
    }
    
    
}
