//
//  AuthService.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation
import Alamofire

class AuthService {
    func login(user: UserLogin, completion: @escaping (Result<SuccesfulLoginResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        NetworkManager.shared.request(.login, method: .post, parameters: parameters, completion: completion)
    }
    
    func register(user: UserLogin, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        NetworkManager.shared.request(.register, method: .post, parameters: parameters, completion: completion)
    }
}

struct TokenData: Decodable {
    let accessToken: String
    let tokenType: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

struct SuccesfulLoginResponse: Decodable {
    let code: String
    let data: TokenData
    let message: String
}

struct FailedLoginResponse: Decodable {
    let code: String
    let message: String
}

struct RegisterResponse: Decodable {
    let success: Bool
}
