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
    
    @IBOutlet var NoteTitle: UILabel!
    @IBOutlet var NoteDetail: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle(isHideNavBar: false)
        noteService.getSpecificNote(note_id: id) { result in
            switch result {
            case .success(let response):
                print(response)
                let NOTE = response.data
                self.NoteDetail.text = NOTE.note
                self.NoteTitle.text = NOTE.title
            case .failure(let error):
                print(error)
            }
        }
    }

}

// Action
extension EditNoteViewController {
    @IBAction func SaveNote(_ sender: Any) {
        let note = Note(id: self.id, title: NoteTitle.text!, note: NoteDetail.text!)
        
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
