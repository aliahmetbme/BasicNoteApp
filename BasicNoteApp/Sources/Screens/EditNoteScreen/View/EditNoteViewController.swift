//
//  EditNoteViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 21.07.2024.
//

import UIKit

class EditNoteViewController: UIViewController {
    let noteService = NoteService()
    var id: Int
    var viewModel = EditNoteViewModel()
    
    private var NoteTitle = UITextView()
    private var NoteDetail = UITextView()
    private var SaveButton = UIButton()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setBackButtonTitle(title: "Edit Note",isHideNavBar: false)
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
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(NoteTitle)
        view.addSubview(NoteDetail)
        view.addSubview(SaveButton)
        
        makeNoteTitle()
        makeNoteDetail()
        makeSaveButton()
        
        SaveButton.addTarget(self, action: #selector(SaveNote), for: .touchUpInside)
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

// UI Coding programatically

extension EditNoteViewController {
    
    private func makeNoteTitle() {
        NoteTitle.font = .systemFont(ofSize: 22, weight: .regular)
        NoteTitle.layer.borderWidth = 0.5
        NoteTitle.layer.borderColor = UIColor.lightGray.cgColor
        NoteTitle.layer.cornerRadius = 10
        
        NoteTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
    }
    
    private func makeNoteDetail() {
        NoteDetail.font = .systemFont(ofSize: 17)
        NoteDetail.layer.borderWidth = 0.5
        NoteDetail.layer.borderColor = UIColor.lightGray.cgColor
        NoteDetail.layer.cornerRadius = 10
        
        NoteDetail.snp.makeConstraints { make in
            make.top.equalTo(NoteTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(137)
        }
        
    }
    
    private func makeSaveButton() {
        SaveButton.backgroundColor = .signuptext
        SaveButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        SaveButton.setTitleColor(.white, for: .normal)
        
        
        SaveButton.setTitle("Save Note", for: .normal)
        SaveButton.makeRadius()
        
        SaveButton.snp.makeConstraints { make in
            make.top.equalTo(NoteDetail.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(133)
        }
    }
}
