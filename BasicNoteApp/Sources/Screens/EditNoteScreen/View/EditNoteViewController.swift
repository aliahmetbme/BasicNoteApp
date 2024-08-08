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
    var viewModel = EditNoteViewModel()
    
    @IBOutlet var NoteTitle: UILabel!
    @IBOutlet var NoteDetail: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle(isHideNavBar: false)
        setupBinding()
        viewModel.getSpecificNote(noteID: id)
    }
    
    private func setupBinding() {
        viewModel.id = id
        
        viewModel.onTakingNoteSucces = { note in
            self.NoteDetail.text = note.note
            self.NoteTitle.text = note.title
        }
        
        viewModel.onSavingNoteFailure = {message in
            self.showToast(message: message, isSuccess: false)
        }
        
        viewModel.onSavigNoteSucces = {message in
            self.showToast(message: message, isSuccess: true)
        }
    }
}

// Action
extension EditNoteViewController {
    @IBAction func SaveNote(_ sender: Any) {
        
        viewModel.noteDetail = self.NoteDetail.text!
        viewModel.title = self.NoteTitle.text!
        
        viewModel.updateNote()
    }
}
