//
//  NotesScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 20.07.2024.
//

import Foundation
import UIKit

class NotesScreenViewController: UIViewController {
    
    @IBOutlet var SearchBar: UISearchBar!
    @IBOutlet var NotesTable: UITableView!
    
    let noteService = NoteService()
    var notesArray: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSettings()
    }
    
    private func initialSettings () {
        
        NotesTable.delegate = self
        NotesTable.dataSource = self
        
        setBackButtonTitle(isHideNavBar: false)
        getAllNotes()

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
    @IBAction func showAddNotePage(_ sender: Any) {
      performSegue(withIdentifier: "showAddNotePage", sender: nil)
    }
    @IBAction func goProfilePage(_ sender: Any) {
        performSegue(withIdentifier: "goProfilePage", sender: nil)
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
            nextVC.onDismiss = {
                self.getAllNotes()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notesArray[indexPath.row]
        let cell = NotesTable.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! NoteViewCell
        
        cell.Note.text = note.note
        cell.Title.text = note.title
        
        return cell
    }
    
    // swipe left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notesArray[indexPath.row]
        let editAction = UIContextualAction(style: .normal, title: "") { (_, _, completionHandler) in
            self.performSegue(withIdentifier: "goEditNoteVC", sender: note.id)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemYellow
        editAction.image = UIImage(systemName: "pencil")
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (_, _, completionHandler) in
            
            let alertController = UIAlertController(title: "Delete Note", message: "Are you sure you want to deletethis note.", preferredStyle: .alert)
            
            let confirmDeleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.noteService.deleteNote(note_id:note.id) { results in
                    switch results {
                    case .success(let response):
                        print(response)
                        self.getAllNotes()
                    case .failure(let error):
                        print(error)
                    }
                }
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
