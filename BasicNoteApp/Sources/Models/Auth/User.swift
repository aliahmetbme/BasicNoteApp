//
//  User.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 10.07.2024.
//

import Foundation

struct UserRegister: Codable {
    let password: String
    let email: String
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case password = "password"
        case email = "email"
        case fullName = "full_name"
    }
}

struct UserLogin: Codable {
    let password: String
    let email: String
}

struct UserUpdate: Codable {
    let fullName: String
    let email: String
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email = "email"
    }
}

struct UserPasswordForgot: Codable {
    let email: String
}

struct ChangePassword: Codable {
    let password: String
    let newPassword: String
    let newPasswordConfirmation: String
    
    private enum CodingKeys: String, CodingKey {
        case password = "password"
        case newPassword = "new_password"
        case newPasswordConfirmation = "new_password_confirmation"
    }
}

