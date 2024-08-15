//
//  AuthService.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation
import Alamofire

class AuthService {
    func login(user: UserLogin, completion: @escaping (Result<SuccesfulLoginResponse, NetworkError>) -> Void) {
        let parameters: Parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        NetworkManager.shared.request(.login, method: .post, parameters: parameters, completion: completion)
    }
    
    func register(user: UserRegister, completion: @escaping (Result<SuccesfullyRegisterResponse, NetworkError>) -> Void) {
        let parameters: Parameters = [
            "email": user.email,
            "full_name": user.fullName,
            "password": user.password
        ]
        
        NetworkManager.shared.request(.register, method: .post, parameters: parameters, completion: completion)
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<SuccesfullyFogetPasswordResponse, NetworkError>) -> Void) {
        
        let parameter: Parameters = ["email": email]
        
        NetworkManager.shared.request(.register, method: .post, parameters: parameter, completion: completion)
    }
    
}
