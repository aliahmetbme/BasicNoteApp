//
//  ErrorResponse.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import Foundation

struct ErrorResponse: Codable, Error {
    let code: String
    let message: String
}
