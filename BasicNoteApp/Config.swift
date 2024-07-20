//
//  Config.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 10.07.2024.
//

import Foundation

struct ApiBaseUrlConfig {
    static let apiBaseUrl = "https://basicnoteapp.mobillium.com/api/"
}

struct RequestTypeConfig {
    static let login = "auth/login"
    static let register = "auth/register"
    static let deleteNote = "notes/"
}
