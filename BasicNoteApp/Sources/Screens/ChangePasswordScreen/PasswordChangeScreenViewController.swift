//
//  PasswordChangeScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit

class PasswordChangeScreenViewController: UIViewController {

    private var Password = UITextField()
    private var NewPassword = UITextField()
    private var ReNewPassword = UITextField()
    private var ChangePasswordButton = UIButton()
    private var ErrorImage = UIImageView()
    private var ErrorMessage = UILabel()

    let userService = UserService()
    var initialPassword: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setBackButtonTitle(title: "Change Password",isHideNavBar: false)
        configure()
        checkIsShouldEnabledSaveChangesButton()
        Password.delegate = self
        NewPassword.delegate = self
        ReNewPassword.delegate = self

    }
    
    private func configure() {
        view.addSubview(Password)
        view.addSubview(NewPassword)
        view.addSubview(ReNewPassword)
        view.addSubview(ErrorImage)
        view.addSubview(ErrorMessage)
        view.addSubview(ChangePasswordButton)
        
        makePassWordField()
        makeNewPassWordField()
        makeReNewPassWordField()
        makeErrorImage()
        makeErrorLabel()
        makeChangePasswordButton()
        
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(turnBack))
        leftBarButton.image = UIImage.navBarItemIcon
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    
    private func checkIsShouldEnabledSaveChangesButton () {
        if (Password.text == "" || NewPassword.text == "" || ReNewPassword.text == "") {
            ChangePasswordButton.isEnabled = false
            ChangePasswordButton.initialDesign()
        } else {
            ChangePasswordButton.isEnabled = true

        }
    }

}

// Actions
extension PasswordChangeScreenViewController {
    @IBAction private func changePassword(_ sender: Any) {
        
        let changePasswordStruct = ChangePassword(password: Password.text!, newPassword: NewPassword.text!, newPasswordConfirmation: ReNewPassword.text!)
        
        userService.changePassword(changePasswordStruct: changePasswordStruct) { result in
            switch result {
            case .success(let response):
                print("Password changed successfully: \(response)")
            case .failure(let error):
                self.Password.showInvalidFunctionError()
                self.NewPassword.showInvalidFunctionError()
                self.ReNewPassword.showInvalidFunctionError()
                self.ErrorImage.isHidden = false
                self.ErrorMessage.text = error.localizedDescription
                self.ErrorMessage.isHidden = false
            }
        }
    }
    
    @objc private func turnBack() {
        navigationController?.popViewController(animated: true)
    }
}

// TextView Delegates
extension PasswordChangeScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkIsShouldEnabledSaveChangesButton()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        checkIsShouldEnabledSaveChangesButton()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        checkIsShouldEnabledSaveChangesButton()
        return true
    }
}


extension PasswordChangeScreenViewController {
    
    private func makePassWordField () {
        let component = Password
        
        component.placeholder = "Password"
        component.initialDesign()
        component.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }

    private func makeNewPassWordField () {
        let component = NewPassword
        
        component.placeholder = "New Password"
        component.initialDesign()
        component.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(Password.snp.bottom).offset(16)
        }
    }

    private func makeReNewPassWordField () {
        
        let component = ReNewPassword
        
        component.placeholder = "New Password Configuration"
        component.initialDesign()
        component.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(NewPassword.snp.bottom).offset(16)
        }
    }
    
    private func makeErrorLabel () {
        ErrorMessage.text = "Error"
        ErrorMessage.textColor = UIColor.error
        
        ErrorMessage.font = .systemFont(ofSize: 12)
        ErrorMessage.snp.makeConstraints { make in
            make.top.equalTo(ReNewPassword.snp.bottom).offset(8)
            make.left.equalTo(ErrorImage.snp.right).offset(5)
            make.centerY.equalTo(ErrorImage)
        }
    }

    private func makeErrorImage () {
        ErrorImage.image = .erroricon
        ErrorImage.frame.size.width = 32
        
        ErrorImage.snp.makeConstraints { make in
            make.top.equalTo(ReNewPassword.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 20, height: 20)) // Boyutu ayarla

        }
    }
    
    private func makeChangePasswordButton() {
        
        var component = ChangePasswordButton
        
        component.setTitle("Change Button", for: .normal)
        component.isEnabled = false

        component.initialDesign()
        component.makeRadius()
        
        component.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.equalTo(63)
            make.top.equalTo(ErrorMessage.snp.bottom).offset(20)
        }
    }
    
}
