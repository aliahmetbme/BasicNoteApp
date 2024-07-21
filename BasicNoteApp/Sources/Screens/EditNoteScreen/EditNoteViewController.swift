//
//  EditNoteViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 21.07.2024.
//

import UIKit

class EditNoteViewController: UIViewController {
    let noteService = NoteService()
    var id: Int = 0
    
    @IBOutlet var note_title: UILabel!
    @IBOutlet var note_detail: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle(isHideNavBar: false)
        noteService.getSpecificNote(note_id: id) { result in
            switch result {
            case .success(let response):
                print(response)
                let NOTE = response.data
                self.note_detail.text = NOTE.note
                self.note_title.text = NOTE.title
            case .failure(let error):
                print(error)
            }
        }
    }

}

// Action
extension EditNoteViewController {
    @IBAction func saveNote(_ sender: Any) {
        let note = Note(id: self.id, title: note_title.text!, note: note_detail.text!)
        
        noteService.updateNote(note: note) {
            result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
