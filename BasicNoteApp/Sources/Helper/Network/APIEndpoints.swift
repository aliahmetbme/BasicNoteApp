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
    case forgotpassword
    case me
    case mynotes(page: Int = 1)
    case updateme
    case updatepassword
    case getNote(note_id: Int)
    case createNote
    case updateNote(note_id: Int)
    case deleteNote(note_id: Int)
    
    var urlString: String {
        switch self {
        case .login:
            print("Api: \(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.login)")
            return "https://basicnoteapp.mobillium.com/api/auth/login"
        case .register:
            return "https://basicnoteapp.mobillium.com/api/auth/register"
        case .getNote(note_id: let note_id):
            return "\(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.deleteNote)\(note_id)"
        case .createNote:
            return "\(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.getNote)"
        case .updateNote(note_id: let note_id):
            return "\(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.getNote)\(note_id)"
        case .deleteNote(note_id: let note_id):
            return "\(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.deleteNote)\(note_id)"
        case .forgotpassword:
            return "https://api.example.com/register"
        case .me:
            return "https://basicnoteapp.mobillium.com/api/users/me"
        case .mynotes(page: let page):
            return "https://basicnoteapp.mobillium.com/api/users/me/notes?page=\(page)"
        case .updateme:
            return "https://basicnoteapp.mobillium.com/api/users/me"
        case .updatepassword:
            return "https://basicnoteapp.mobillium.com/api/users/me/password"
        }
    }
}
