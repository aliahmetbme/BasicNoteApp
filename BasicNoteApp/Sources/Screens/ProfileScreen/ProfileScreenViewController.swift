//
//  ProfileScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    @IBOutlet var FullNameField: UITextField!
    @IBOutlet var EmailAdressField: UITextField!
    @IBOutlet var ErrorImage: UIImageView!
    @IBOutlet var ErrorMessage: UILabel!
    
    var password = ""
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        userService.getCurrentUser { [self] result in
            switch result {
            case .success(let response):
                FullNameField.text = response.data.full_name
                EmailAdressField.text = response.data.email
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initialDesign() {
        FullNameField.initialDesign()
        EmailAdressField.initialDesign()
        ErrorImage.isHidden = true
        ErrorImage.isHidden = true
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
    }
    
    @IBAction func goChangePasswordPage(_ sender: Any) {
        performSegue(withIdentifier: "goChangePasswordVC", sender: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        initialDesign()
        
        let currentUser = UserUpdate(full_name: FullNameField.text!, email: EmailAdressField.text!)
        
        userService.updateCurrentUser(currentUser: currentUser) { result in
            switch result {
            case .success(_):
                print("Succesfully Updated")
            case .failure(let error):
                self.FullNameField.showInvalidFunctionError()
                self.EmailAdressField.showInvalidFunctionError()
                self.ErrorImage.isHidden = false
                self.ErrorMessage.text = error.localizedDescription
                self.ErrorMessage.isHidden = false
            }
        }
    }
}


