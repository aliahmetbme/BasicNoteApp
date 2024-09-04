//
//  PasswordChangeScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit
import SnapKit

class PasswordChangeScreenViewController: UIViewController {
    
    private var Password = UITextField()
    private var NewPassword = UITextField()
    private var ReNewPassword = UITextField()
    private var ChangePasswordButton = UIButton()
    private var ErrorImage = UIImageView()
    private var ErrorMessage = UILabel()
    
    let viewModel = PasswordChangeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle(title: "Change Password",isHideNavBar: false)
        configure()
        initialSettings()
        setupBindings()
    }
    
    private func initialSettings() {
        Password.delegate = self
        NewPassword.delegate = self
        ReNewPassword.delegate = self
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
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
        
        ChangePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
    }
    
    
    private func setupBindings() {
        
        viewModel.validateInputs()
        
        viewModel.onSuccesPasswordChange = { [weak self] message in
            self?.showToast(message: message, isSuccess: true)
        }
        
        viewModel.onErrorPasswordChange = { [weak self] message in
            self?.ErrorMessage.text = message
            self?.ErrorMessage.isHidden = false
            self?.ErrorImage.isHidden = false
        }
        
        viewModel.isSaveButtonEnabled = { [weak self] isEnabled in
            self?.ChangePasswordButton.isEnabled = isEnabled
            self?.ChangePasswordButton.initialDesign()
        }
    }
}
// Actions
extension PasswordChangeScreenViewController {
    @objc private func changePassword(_ sender: Any) {
        
        ErrorImage.isHidden = true
        ErrorMessage.isHidden = true

        viewModel.changePassword()
    }
    
    @objc private func turnBack() {
        navigationController?.popViewController(animated: true)
    }
}

// TextView Delegates
extension PasswordChangeScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.validateInputs()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.validateInputs()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        updateViewModel(textField: textField)
        viewModel.validateInputs()
        return true
    }
    
    private func updateViewModel(textField: UITextField) {
        if textField == Password {
            viewModel.password = textField.text ?? ""
        } else if textField == NewPassword {
            viewModel.newPassword = textField.text ?? ""
        } else if textField == ReNewPassword {
            viewModel.reNewPassword = textField.text ?? ""
        }
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
        ErrorMessage.isHidden = true
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
        ErrorImage.isHidden = true
        ErrorImage.frame.size.width = 32
        
        ErrorImage.snp.makeConstraints { make in
            make.top.equalTo(ReNewPassword.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 20, height: 20)) // Boyutu ayarla

        }
    }
    
    private func makeChangePasswordButton() {
        
        let component = ChangePasswordButton
        
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
