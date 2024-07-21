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
    
    func deleteNote(note_id: Int, completion: @escaping (Result<DeletedNote, Error>) -> Void) {
        let parameters: Parameters = [":note_id": note_id]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]

        NetworkManager.shared.request(.deleteNote(note_id: note_id), method: .delete, parameters: parameters ,headers: headers, completion: completion)
    }
        
    func getAllNotes(page: Int = 1, completion: @escaping (Result<NoteResponseModel, Error>) -> Void) {
        
        let parameters: Parameters = ["page": page]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token)" ]
        
        NetworkManager.shared.request(.mynotes(page: page), method: .get, parameters: parameters,headers: headers,completion: completion)
        
    }
    
    func getSpecificNote(note_id: Int, completion: @escaping ((Result<SpecificNoteResponseModel, Error>) -> Void)) {
        let parameters: Parameters = ["note_id": note_id ]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token)" ]
        
        NetworkManager.shared.request(.getNote(note_id: note_id), method: .get,parameters: parameters ,headers: headers,completion: completion)
    }
    
    func updateNote(note: Note, completion: @escaping ((Result<SpecificNoteResponseModel, Error>) -> Void)) {
        let parameters: Parameters = ["note_id": note.id, "title": note.title, "note": note.note]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token)" ]
        
        NetworkManager.shared.request(.updateNote(note_id: note.id), method: .put,parameters: parameters ,headers: headers,completion: completion)
    }
    
    func createNote(note: UploadNoteModel, completion: @escaping ((Result<AddNoteResponseModel, Error>) -> Void)) {
        let parameters: Parameters = ["title": note.title, "note": note.note]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token)" ]
        
        NetworkManager.shared.request(.createNote, method: .post, parameters: parameters ,headers: headers,completion: completion)

    }
}
