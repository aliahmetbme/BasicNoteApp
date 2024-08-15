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
    
    private var viewModel = ProfileScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        setupBinding()
        viewModel.getCurrentUser()
    }
    
    private func initialDesign() {
        
        FullNameField.initialDesign()
        EmailAdressField.initialDesign()
        
        ErrorImage.isHidden = true
    }

    private func setupBinding() {
    
        viewModel.onErrorCurrentUser = { errorMessage in
            self.ErrorMessage.text = errorMessage
            self.ErrorMessage.isHidden = false
            self.ErrorImage.isHidden = false
        }
        
        viewModel.onSuccesCurrentUser = { userData in
            self.FullNameField.text = userData.fullName
            self.EmailAdressField.text = userData.email
        }
        
        viewModel.onSuccesUpdateCurrentUser = { message in
            self.showToast(message: message, isSuccess: true)
        }
    }
}

// Actions
extension ProfileScreenViewController {
  
    @IBAction func returnNotesPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        performSegue(withIdentifier: "signout", sender: nil)
    }
    
    @IBAction func goChangePasswordPage(_ sender: Any) {
        performSegue(withIdentifier: "goChangePasswordVC", sender: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        initialDesign()
        
        viewModel.fullName = FullNameField.text!
        viewModel.email = EmailAdressField.text!
        
        viewModel.updateCurrentUser()
    }
}


