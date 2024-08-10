//
//  AddNoteScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 21.07.2024.
//

import UIKit
import SnapKit

class AddNoteScreenViewController: UIViewController {

    private var TitleLabel = UILabel()
    private var NoteDescriptionLabel = UILabel()

    private var NoteTitle =  UITextView()
    private var NoteDescription = UITextView()

    private var AddNoteButton = UIButton()

    let noteService = NoteService()
    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(TitleLabel)
        view.addSubview(NoteTitle)
        view.addSubview(NoteDescriptionLabel)
        view.addSubview(NoteDescription)
        view.addSubview(AddNoteButton)
        
        makeTitleLabel()
        makeNoteTitle()
        makeNoteDescriptionLabel()
        makeNoteDescription()
        makeAddNoteButton()
        
        AddNoteButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
    }
}

// Action

extension AddNoteScreenViewController {
    @objc func addNote() {
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

// Initial UI Coding

extension AddNoteScreenViewController {
    private func makeTitleLabel() {
        TitleLabel.text = "Title"
        TitleLabel.font = .boldSystemFont(ofSize: 17)
        TitleLabel.textColor = .black
        TitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(5)
            make.height.equalTo(30) // Yükseklik ayarı
        }
    }
    
    private func makeNoteTitle() {
        NoteTitle.font = .systemFont(ofSize: 15)
        NoteTitle.textColor = .black
        NoteTitle.layer.borderWidth = 1.0
        NoteTitle.layer.borderColor = UIColor.lightGray.cgColor
        NoteTitle.layer.cornerRadius = 10
        
        NoteTitle.snp.makeConstraints { make in
            make.top.equalTo(TitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
    }
    
    private func makeNoteDescriptionLabel() {
        NoteDescriptionLabel.text = "Note"
        NoteDescriptionLabel.font = .boldSystemFont(ofSize: 17)
        NoteDescriptionLabel.textColor = .black
        NoteDescription.layer.cornerRadius = 15

        NoteDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(NoteTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }
    }
    
    private func makeNoteDescription() {
        NoteDescription.font = .systemFont(ofSize: 15)
        NoteDescription.textColor = .black
        NoteDescription.layer.borderWidth = 1.0
        NoteDescription.layer.borderColor = UIColor.lightGray.cgColor
        NoteDescription.snp.makeConstraints { make in
            make.top.equalTo(NoteDescriptionLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.greaterThanOrEqualTo(120)
        }
    }
    
    private func makeAddNoteButton() {
        AddNoteButton.backgroundColor = .signuptext
        AddNoteButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        AddNoteButton.setTitleColor(.white, for: .normal)

        let image = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        AddNoteButton.setImage(image, for: .normal)
        AddNoteButton.setTitle(" Add Note", for: .normal)
        AddNoteButton.layer.cornerRadius = 8
        AddNoteButton.layer.masksToBounds = true
        
        AddNoteButton.snp.makeConstraints { make in
            make.top.equalTo(NoteDescription.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
    }
}
