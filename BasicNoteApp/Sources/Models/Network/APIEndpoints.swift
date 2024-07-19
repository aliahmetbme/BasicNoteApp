//
//  APIEndpoints.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation

enum APIEndpoint {
    case login
    case register
    case fetchNotes
    case createNote
    case updateNote
    case deleteNote
    
    var urlString: String {
        switch self {
        case .login:
            print("Api: \(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.login)")
            return "https://basicnoteapp.mobillium.com/api/auth/login"
        case .register:
            return "https://api.example.com/register"
        case .fetchNotes:
            return "https://api.example.com/register"
        case .createNote:
            return "https://api.example.com/register"
        case .updateNote:
            return "https://api.example.com/register"
        case .deleteNote:
            return "https://api.example.com/register"
        }
    }
}
