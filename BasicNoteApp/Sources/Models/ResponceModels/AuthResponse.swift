//
//  AuthResponse.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation

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

struct SuccesfullyRegisterResponse: Decodable {
    let code: String
    let data: TokenData
    let message: String
}

struct SuccesfullyFogetPasswordResponse: Decodable {
    let code: String
    let data: String
    let message: String
}
