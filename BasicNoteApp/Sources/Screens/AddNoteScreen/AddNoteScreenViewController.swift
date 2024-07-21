//
//  AddNoteScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 21.07.2024.
//

import UIKit

class AddNoteScreenViewController: UIViewController {

    @IBOutlet var note_title: UITextView!
    @IBOutlet var note_description: UITextView!
    let noteService = NoteService()
    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func addNote(_ sender: Any) {
        let new_note = UploadNoteModel(title: note_title.text!, note: note_description.text!)
        noteService.createNote(note: new_note) { result in
            switch result {
            case .success(let response):
                print(response.code)
                self.dismiss(animated: true) {
                    self.onDismiss?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
