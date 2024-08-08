//
//  EditNoteViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 8.08.2024.
//

import Foundation

protocol IEditNoteViewModel {
    func updateNote()
    func getSpecificNote(noteID: Int)
}


class EditNoteViewModel: IEditNoteViewModel {
    
    private let noteService = NoteService()
    
    var onTakingNoteSucces: ((Note) -> Void)?
    var onTakingNoteFailure: ((String) -> Void)?
    var onSavigNoteSucces: ((String) -> Void)?
    var onSavingNoteFailure: ((String) -> Void)?
    
    var id: Int = 0
    var noteDetail: String = ""
    var title: String = ""
    
    func updateNote() {
        let note = Note(id: id, title: title, note: noteDetail)
        
        noteService.updateNote(note: note) {
            result in
            switch result {
            case .success(let response):
                self.onSavigNoteSucces?(response.message)
            case .failure(let error):
                self.onSavingNoteFailure?(error.localizedDescription)
            }
        }
    }
    
    func getSpecificNote(noteID: Int) {
        noteService.getSpecificNote(note_id: noteID) { result in
            switch result {
            case .success(let response):
                print(response)
                let note = response.data
                self.onTakingNoteSucces?(note)
            case .failure(let error):
                print(error)
                self.onTakingNoteFailure?(error.localizedDescription)
            }
        }
    }
}
