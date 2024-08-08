//
//  NotesScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 20.07.2024.
//

import Foundation
import UIKit

class NotesScreenViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var notesTable: UITableView!
    
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
        
        notesTable.delegate = self
        notesTable.dataSource = self
        
        setBackButtonTitle(isHideNavBar: false)

        self.navigationItem.titleView = searchBar
        self.navigationItem.hidesBackButton = true
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
        let cell = notesTable.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! NoteViewCell
        
        cell.note.text = note.note
        cell.title.text = note.title
        
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
