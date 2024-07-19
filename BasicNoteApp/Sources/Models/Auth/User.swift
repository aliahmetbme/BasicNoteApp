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

struct UserPasswordForgot: Codable {
    let email: String
}


