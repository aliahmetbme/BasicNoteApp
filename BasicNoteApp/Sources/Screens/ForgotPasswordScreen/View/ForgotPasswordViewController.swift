//
//  ForgotPasswordViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 3.07.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet private var EmailAdressLabel: UITextField!
    @IBOutlet private var ResetPasswordButton: UIButton!
    var viewModel = ForgetPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialDesign()
        setupBinding()
    }
    
    private func initialDesign() {
        ResetPasswordButton.makeRadius()
        EmailAdressLabel.initialDesign()
        setBackButtonTitle(isHideNavBar: false)
    }
    
    private func setupBinding() {
        
        viewModel.onSuccesfullySenginForhgetRequest = { message in
            print(message)
            self.showToast(message: message, isSuccess: true)
        }
        viewModel.onErrorSenginForhgetRequest = { message in
            print(message)
            self.showToast(message: message, isSuccess: false)
        }
    }
    
    
}

// Actions
extension ForgotPasswordViewController {
    
    @IBAction private func resetPassword(_ sender: Any) {
        // reset password
        viewModel.email = EmailAdressLabel.text!
        viewModel.resetPassword()
    }
}
