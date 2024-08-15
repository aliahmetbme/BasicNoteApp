//
//  UserResponse.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation

struct CurrentUserResponse: Codable {
    let code: String
    let data: UserData
    let message: String
}

struct UserData: Codable {
    let id: Int
    let fullName: String
    let email: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
        case email = "email"
    }
}

struct UserUpdatedResponse: Codable {
    let code: String
    let data: UserData
    let message: String
}

struct UserPasswordChangeResponse: Codable {
    let code: String
    let data: String?
    let message: String
}
