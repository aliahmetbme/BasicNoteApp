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
    let full_name: String
}

struct UserLogin: Codable {
    let password: String
    let email: String
}

struct UserUpdate: Codable {
    let full_name: String
    let email: String
}

struct UserPasswordForgot: Codable {
    let email: String
}

struct ChangePassword: Codable {
    let password: String
    let new_password: String
    let new_password_confirmation: String
}

