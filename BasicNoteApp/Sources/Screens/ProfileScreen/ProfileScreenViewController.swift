//
//  ProfileScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    @IBOutlet var fullname_Label: UITextField!
    @IBOutlet var emailAdressLabel: UITextField!
    var password = ""
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userService.getCurrentUser { [self] result in
            switch result {
            case .success(let response):
                fullname_Label.text = response.data.full_name
                emailAdressLabel.text = response.data.email
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
}

// Actions
extension ProfileScreenViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goChangePasswordVC" {
            if let password = sender as? String {
                let nextVC = segue.destination as! PasswordChangeScreenViewController
                nextVC.initialPassword = password
            }
        }
     }
    
    @IBAction func returnNotesPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accesToken")
        performSegue(withIdentifier: "signout", sender: nil)
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func goChangePasswordPage(_ sender: Any) {
        performSegue(withIdentifier: "goChangePasswordVC", sender: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let currentUser = UserUpdate(full_name: fullname_Label.text!, email: emailAdressLabel.text!)
        userService.updateCurrentUser(currentUser: currentUser) { result in
            switch result {
            case .success(_):
                print("Succesfully Updated")
            case .failure(_):
                print("Error")
            }
        }
    }
}


