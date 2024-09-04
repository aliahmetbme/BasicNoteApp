//
//  NoteScreenViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 8.08.2024.
//

import Foundation

protocol INoteScreenViewModel {
    func getAllNotes()
    func deleteNote(id: Int)
}

class NoteScreenViewModel: INoteScreenViewModel {
    
    let noteService = NoteService()
   
    var noteTakenSucces:(([Note]) -> Void)?
    var noteTakenFailure:((String) -> Void)?
    var noteDeleteFailure:((String) -> Void)?
    var noteDeleteSucces:((String) -> Void)?
    
    func getAllNotes() {
        noteService.getAllNotes() {
            result in
            switch result {
            case.success(let response):
                self.noteTakenSucces?(response.data.data)
            case .failure(let error):
                self.noteTakenFailure?(error.message)
            }
        }
    }
    
    func deleteNote(id: Int) {
        noteService.deleteNote(note_id:id) { results in
            switch results {
            case .success(let response):
                self.noteDeleteSucces?(response.message)
                self.getAllNotes()
            case .failure(let error):
                self.noteDeleteFailure?(error.message)
            }
        }
    }
}
