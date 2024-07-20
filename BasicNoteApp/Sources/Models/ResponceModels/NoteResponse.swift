//
//  NoteResponse.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation

struct NoteResponseModel: Codable {
    let code: String
    let data: NoteData
    let message: String
}

struct Note: Codable{
    let title: String
    let note: String
    let id: Int
}

struct NoteData: Codable {
    let currentPage: Int
    let data: [Note]
    let firstPageURL: String
    let from: Int?
    let lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String
    let to: Int?
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to
        case total
    }
}

struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}
