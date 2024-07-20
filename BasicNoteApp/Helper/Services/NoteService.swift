//
//  NoteService.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation
import Alamofire

class NoteService {
    func createNote(title: String, note: String, completion: @escaping (Result<NoteResponseModel, Error>) -> Void) {
        let parameters: Parameters = [
            "title": title,
            "note": note
        ]
        
        NetworkManager.shared.request(.createNote, method: .post, parameters: parameters, completion: completion)
    }
    
    func deleteNote() {}
    
    func updateNote() {}
    
    func getAllNotes(page: Int = 1, completion: @escaping (Result<NoteResponseModel, Error>) -> Void) {
        let parameters: Parameters = ["page":page]
        
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
        
        NetworkManager.shared.request(.mynotes(page: page), method: .get, parameters: parameters,headers: headers,completion: completion)
        
    }
    
    
}
