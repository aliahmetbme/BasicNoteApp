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
    @IBOutlet var AddNoteButton: UIButton!

    let viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        setupBinding()

    }
    
    private func setupBinding() {
        viewModel.note = NoteDescription.text ?? ""
        viewModel.title = NoteTitle.text ?? ""
        
        viewModel.isAddButtonEnabled = { isEnabled in
            self.AddNoteButton.isEnabled = isEnabled
            isEnabled ?  self.AddNoteButton.enableDesign() :  self.AddNoteButton.disabledDesign()
        }
        
        viewModel.onSucces = {message in
            print(message)
            self.showToast(message: message, isSuccess: true)

        }

        viewModel.onFailure = {message in
            print(message)
            self.showToast(message: message, isSuccess: false)

        }
    }
    
    @IBAction func addNote(_ sender: Any) {
            viewModel.addNewNote()
    }
    
    private func initialSetting() {
        NoteTitle.delegate = self
        NoteDescription.delegate = self
    }
}

// UITextFieldDelegate
extension AddNoteScreenViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textField: UITextView) {
        updateViewModel(from: textField)
        viewModel.isValidInput()
    }

    func textViewDidEndEditing(_ textField: UITextView) {
        updateViewModel(from: textField)
        viewModel.isValidInput()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateViewModel(from: textView)
        viewModel.isValidInput()
    }
    
    func textFieldShouldClear(_ textField: UITextView) -> Bool {
        textField.text = ""
        updateViewModel(from: textField)
        viewModel.isValidInput()
        return true
    }
    
    private func updateViewModel(from textField: UITextView) {
        switch textField {
        case NoteTitle:
            viewModel.title = textField.text ?? ""
        case NoteDescription:
            viewModel.note = textField.text ?? ""
        default:
            break
        }
    }
}
