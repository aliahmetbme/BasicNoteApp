//
//  NotesScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 20.07.2024.
//

import Foundation
import UIKit

class NotesScreenViewController: UIViewController {

    private var SearchBar = UISearchBar()
    private var NotesTable = UITableView()
    private var AddNoteButton = UIButton()
    
    let noteService = NoteService()
    var viewModel = NoteScreenViewModel()
    var notesArray: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.getAllNotes()
        initialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSettings()
    }
    
    
    private func setupBindings() {

        viewModel.noteTakenSucces =  { data in
            self.notesArray = data
            self.notesTable.reloadData()
        }
        
        viewModel.noteTakenFailure =  { message in
            print(message)
            self.showToast(message: message, isSuccess: false)
        }
        
        viewModel.noteDeleteSucces =  { message in
            print(message)
            self.showToast(message: message, isSuccess: true)
        }
        
        viewModel.noteDeleteSucces =  { message in
            print(message)
            self.showToast(message: message, isSuccess: true)
        }
    }
    
    private func initialSettings () {
        
        NotesTable.delegate = self
        NotesTable.dataSource = self
        NotesTable.register(NoteViewCell.self, forCellReuseIdentifier: NoteViewCell.Identifier.custom.rawValue)
      
        setBackButtonTitle(isHideNavBar: false)
        configure()
        
        self.navigationItem.titleView = SearchBar
        self.navigationItem.hidesBackButton = true
    }
    
    private func noteTakenSucces(data: [Note]) {
        
        self.notesArray = data
        self.NotesTable.reloadData()
    }
    
    private func noteTakenFailure(error: Error) {
        
        print(error)
    }
    
    private func configure() {
        view.addSubview(NotesTable)
        view.addSubview(AddNoteButton)
        
        makeNotesTable()
        makeAddNotesTable()
        
        let leftBarButton = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(goProfilePage))
        leftBarButton.image = UIImage.navBarItemIcon
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        AddNoteButton.addTarget(self, action: #selector(showAddNotePage), for: .touchUpInside)
        AddNoteButton.addTarget(self, action: #selector(showAddNotePage), for: .touchUpInside)
    }

    private func getAllNotes() {
        
        noteService.getAllNotes() {
            result in
            switch result {
            case.success(let response):
                self.noteTakenSucces(data: response.data.data)
            case .failure(let error):
                self.noteTakenFailure(error: error)
            }
        }
    }
}

// Actions
extension NotesScreenViewController {
    @objc func showAddNotePage() {
        navigationController?.modalPresentationStyle = .popover
        self.present(AddNoteScreenViewController(), animated: true)
    }
    @objc func goProfilePage(_ sender: Any) {
        navigationController?.pushViewController(ProfileScreenViewController(), animated: true)
    }
    
}

// Table View
extension NotesScreenViewController: UITableViewDelegate, UITableViewDataSource {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goEditNoteVC") {
            if let id = sender as? Int {
                let nextVC = segue.destination as! EditNoteViewController
                nextVC.id = id
            }
        } else if (segue.identifier ==  "showAddNotePage") {
            let nextVC = segue.destination as! AddNoteScreenViewController
            // dismis olunca geliyordu sor
            nextVC.viewModel.onDismiss = {
                self.viewModel.getAllNotes()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notesArray[indexPath.row]
        
        guard let cell = NotesTable.dequeueReusableCell(withIdentifier: NoteViewCell.Identifier.custom.rawValue, for: indexPath) as? NoteViewCell else {return UITableViewCell()}
        
        cell.Note.text = note.note
        cell.Title.text = note.title
        
        return cell
    }
    
    // swipe left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notesArray[indexPath.row]
        
        let editAction = UIContextualAction(style: .normal, title: "") { (_, _, completionHandler) in
            
            let EditNoteVC = EditNoteViewController(id: note.id)
            self.navigationController?.pushViewController(EditNoteVC, animated: true)

            completionHandler(true)
        }
        editAction.backgroundColor = .systemYellow
        editAction.image = UIImage(systemName: "pencil")
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (_, _, completionHandler) in
            
            let alertController = UIAlertController(title: "Delete Note", message: "Are you sure you want to deletethis note.", preferredStyle: .alert)
            
            let confirmDeleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.viewModel.deleteNote(id: note.id)
            }
            
            let cancelDeleteAction = UIAlertAction(title: "Cancel", style: .default)

            alertController.addAction(cancelDeleteAction)
            alertController.addAction(confirmDeleteAction)
            self.present(alertController, animated: true,completion: nil)

            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
}

// Initial Programatic UI
extension NotesScreenViewController {
    private func makeNotesTable() {
        NotesTable.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(AddNoteButton.snp.top).offset(5)
        }
    }
    
    private func makeAddNotesTable() {
        AddNoteButton.backgroundColor = .signuptext
        AddNoteButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        AddNoteButton.tintColor = .white
        let image = UIImage(systemName: "plus")
        image?.withTintColor(.white)
        AddNoteButton.setImage(image, for: .normal)
        AddNoteButton.setTitle(" Add Note", for: .normal)
        AddNoteButton.makeRadius()
        
        AddNoteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.right.left.lessThanOrEqualTo(130)
            make.height.equalTo(41)
            make.bottom.equalToSuperview().inset(25)
        }
    }
}
