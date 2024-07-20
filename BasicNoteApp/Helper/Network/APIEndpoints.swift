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
    case getNotes
    case forgotpassword
    case me
    case mynotes(page: Int = 1)
    case updateme
    case updatepassword
    case getNote
    case createNote
    case updateNote
    case deleteNote
    
    var urlString: String {
        switch self {
        case .login:
            print("Api: \(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.login)")
            return "https://basicnoteapp.mobillium.com/api/auth/login"
        case .register:
            return "https://basicnoteapp.mobillium.com/api/auth/register"
        case .getNotes:
            return "https://api.example.com/register"
        case .createNote:
            return "https://api.example.com/register"
        case .updateNote:
            return "https://api.example.com/register"
        case .deleteNote:
            return "https://api.example.com/register"
        case .forgotpassword:
            return "https://api.example.com/register"
        case .me:
            return "https://api.example.com/register"
        case .mynotes(page: let page):
            return "https://basicnoteapp.mobillium.com/api/users/me/notes?page=\(page)"
        case .updateme:
            return "https://api.example.com/register"
        case .updatepassword:
            return "https://api.example.com/register"
        case .getNote:
            return "https://api.example.com/register"
        }
    }
}
