//
//  AddNoteViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 8.08.2024.
//

import Foundation

protocol IAddNoteViewModel {
    func addNewNote()
    func isValidInput()
}

class AddNoteViewModel: IAddNoteViewModel {

    let noteService = NoteService()
    var onDismiss: (() -> Void)?
    
    var onSucces:((String) -> Void)?
    var onFailure:((String) -> Void)?
    var isAddButtonEnabled:((Bool) -> Void)?
    
    var note:String?
    var title:String?
    
    func addNewNote() {
        let newNote = UploadNoteModel(title: title!, note: note!)
        
        noteService.createNote(note: newNote) { result in
            switch result {
            case .success(let response):
                self.onSucces?(response.message)
            case .failure(let error):
                self.onFailure?(error.message)
            }
        }
    }
    
    func isValidInput() {
        let isValid = !note!.isEmpty && !title!.isEmpty
        isAddButtonEnabled?(isValid)
    }
}
