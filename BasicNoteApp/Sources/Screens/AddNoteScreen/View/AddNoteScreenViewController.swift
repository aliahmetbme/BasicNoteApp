//
//  AddNoteScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 21.07.2024.
//

import UIKit

class AddNoteScreenViewController: UIViewController {
    
    private var TitleLabel = UILabel()
    private var NoteDescriptionLabel = UILabel()

    private var NoteTitle =  UITextView()
    private var NoteDescription = UITextView()

    private var AddNoteButton = UIButton()
    
    let viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        setupBinding()
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

    
    private func setupBinding() {
        viewModel.note = NoteDescription.text ?? ""
        viewModel.title = NoteTitle.text ?? ""
        
        viewModel.isAddButtonEnabled = { isEnabled in
            self.AddNoteButton.isEnabled = isEnabled
            self.AddNoteButton.initialDesign()
        }
        
        viewModel.onSucces = {message in
            print(message)
            self.showToast(message: message, isSuccess: true)
            self.NoteTitle.text = ""
            self.NoteDescription.text = ""
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
            make.height.equalTo(30)
        }
    }
    
    private func makeNoteTitle() {
        NoteTitle.font = .systemFont(ofSize: 15)
        NoteTitle.textColor = .black
        NoteTitle.layer.borderWidth = 0.5
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
        NoteDescription.layer.cornerRadius = 10

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
        NoteDescription.layer.borderWidth = 0.5
        NoteDescription.layer.borderColor = UIColor.lightGray.cgColor
        NoteDescription.layer.cornerRadius = 20
        
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
