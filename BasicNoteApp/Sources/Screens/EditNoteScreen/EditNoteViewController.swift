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
        setBackButtonTitle(title:"Edit Page",isHideNavBar: false)
        configure()
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
    @objc private func SaveNote() {
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


// UI Coding programatically

extension EditNoteViewController {
    
    private func makeNoteTitle() {
        NoteTitle.font = .systemFont(ofSize: 22, weight: .regular)
        NoteTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(5)
            make.height.equalTo(40)
        }
    }
    
    private func makeNoteDetail() {
        NoteDetail.font = .systemFont(ofSize: 17)
        NoteDetail.snp.makeConstraints { make in
            make.top.equalTo(NoteTitle.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(5)
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
