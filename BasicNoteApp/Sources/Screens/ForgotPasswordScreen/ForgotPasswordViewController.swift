//
//  ForgotPasswordViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 3.07.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    private var ForgotPasswordLabel = UILabel()
    private var ForgotPasswordMessageLabel = UILabel()
    
    private var EmailAdressField = UITextField()
    
    private var ResetPasswordButton =  UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        initialDesign()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(ForgotPasswordLabel)
        view.addSubview(ForgotPasswordMessageLabel)
        view.addSubview(EmailAdressField)
        view.addSubview(ResetPasswordButton)
        
        makeforgetPasswordLabel()
        makeforgetPasswordMessageLabel()
        makeEmailAddressField()
        makeResetPasswordButton()
    }
    
    
    private func initialDesign() {
        setBackButtonTitle(isHideNavBar: false)
    }
}

// Actions
extension ForgotPasswordViewController {
    
    @IBAction private func resetPassword(_ sender: Any) {
        // reset password
        if !EmailAdressField.isValidEmail(email: EmailAdressField.text!) {
            EmailAdressField.showInvalidFunctionError()
        }
    }
}
// Initial UI Coding
extension ForgotPasswordViewController {
    
    private func makeforgetPasswordLabel() {
        ForgotPasswordLabel.text = "Forgot Password"
        ForgotPasswordLabel.font = .boldSystemFont(ofSize: 26)
        ForgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    private func makeforgetPasswordMessageLabel() {
        ForgotPasswordMessageLabel.text = "Confirm your email and we’llsend the instructions."
        ForgotPasswordMessageLabel.textColor = .lightGray
        ForgotPasswordLabel.textAlignment = .center
        
        ForgotPasswordMessageLabel.font = .systemFont(ofSize: 15, weight: .medium)
        ForgotPasswordMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(ForgotPasswordLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
 
    private func makeEmailAddressField() {
        EmailAdressField.initialDesign()
        
        EmailAdressField.placeholder = "Full Name"
        EmailAdressField.initialDesign()
        EmailAdressField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(ForgotPasswordMessageLabel.snp.bottom).offset(30)
        }
    }  
    
    private func makeResetPasswordButton() {
        ResetPasswordButton.makeRadius()
        ResetPasswordButton.isEnabled = false
        ResetPasswordButton.initialDesign()
        ResetPasswordButton.setTitle("Reset Password", for: .normal)
        
        ResetPasswordButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.equalTo(63)
            make.top.equalTo(EmailAdressField.snp.bottom).offset(40)
        }
    }
}
