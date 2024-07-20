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
    let full_name: String
    let email: String
}
