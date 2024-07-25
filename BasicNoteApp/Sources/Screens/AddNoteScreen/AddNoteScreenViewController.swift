//
//  AddNoteScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 21.07.2024.
//

import UIKit

class AddNoteScreenViewController: UIViewController {

    @IBOutlet var NoteTitle: UITextView!
    @IBOutlet var NoteDescription: UITextView!
    let noteService = NoteService()
    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func addNote(_ sender: Any) {
        let new_note = UploadNoteModel(title: NoteTitle.text!, note: NoteDescription.text!)
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
