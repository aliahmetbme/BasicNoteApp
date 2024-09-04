//
//  ProfileScreenViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    private var FullNameField = UITextField()
    private var EmailAdressField = UITextField()
    private var ErrorImage = UIImageView()
    private var ErrorMessage = UILabel()
    private var SaveButton = UIButton()
    private var ChangePasswordButton = UIButton()
    private var SignOutButton = UIButton()
    
    var password = ""
    
    private var viewModel = ProfileScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle(title: "Profile",isHideNavBar: false)
        configure()
        setupBinding()
        viewModel.getCurrentUser()
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
    
    private func configure() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(FullNameField)
        view.addSubview(EmailAdressField)
        view.addSubview(ErrorImage)
        view.addSubview(ErrorMessage)
        view.addSubview(SaveButton)
        view.addSubview(ChangePasswordButton)
        view.addSubview(SignOutButton)
        
        makeFullNameLabel()
        makeEmailAdressLabel()
        makeErrorImage()
        makeErrorLabel()
        makeSaveButton()
        makeChangePasswordButton()
        makeSingOutButton()
        
        let leftBarButton = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(returnNotesPage))
        leftBarButton.image = UIImage.navBarItemIcon
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        SignOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        SaveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        ChangePasswordButton.addTarget(self, action: #selector(goChangePasswordPage), for: .touchUpInside)
    }
}

// Actions
extension ProfileScreenViewController {
  
    @IBAction func returnNotesPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accesToken")
        navigationController?.pushViewController(LoginViewController(), animated: false)
    }
    
    @IBAction func goChangePasswordPage(_ sender: Any) {
        navigationController?.pushViewController(PasswordChangeScreenViewController(), animated: true)
    }
    
    @IBAction func saveChanges(_ sender: Any) {

        ErrorImage.isHidden = true
        ErrorMessage.isHidden = true

        viewModel.fullName = FullNameField.text!
        viewModel.email = EmailAdressField.text!
        
        viewModel.updateCurrentUser()
    }
}

// Initial UI Programing

extension ProfileScreenViewController {
    
    private func makeFullNameLabel () {
        FullNameField.placeholder = "Full Name"
        FullNameField.initialDesign()
        FullNameField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
    }
    
    private func makeEmailAdressLabel () {
        EmailAdressField.placeholder = "Email Adress"
        EmailAdressField.initialDesign()
        EmailAdressField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(FullNameField.snp.bottom).offset(20)
        }
    }
    
    private func makeErrorLabel () {
        ErrorMessage.text = "Error"
        ErrorMessage.isHidden = true
        ErrorMessage.textColor = UIColor.error
        ErrorMessage.font = .systemFont(ofSize: 12)
        ErrorMessage.snp.makeConstraints { make in
            make.top.equalTo(EmailAdressField.snp.bottom).offset(8)
            make.left.equalTo(ErrorImage.snp.right).offset(5)
            make.centerY.equalTo(ErrorImage)
        }
    }

    private func makeErrorImage () {
        ErrorImage.image = .erroricon
        ErrorImage.isHidden = true
        ErrorImage.snp.makeConstraints { make in
            make.top.equalTo(EmailAdressField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    private func makeSaveButton() {
        SaveButton.setTitle("Save", for: .normal)
        SaveButton.initialDesign()
        SaveButton.makeRadius()
        
        SaveButton.snp.makeConstraints { make in
            make.top.equalTo(ErrorMessage.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(63)
        }
    }

    private func makeChangePasswordButton() {
        ChangePasswordButton.setTitle("Change Password", for: .normal)
        ChangePasswordButton.setTitleColor(UIColor(named: "signuptext"), for: .normal)
        ChangePasswordButton.titleLabel?.font = .systemFont(ofSize: 14)

        ChangePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(SaveButton.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
        }
    }

    private func makeSingOutButton() {
        SignOutButton.setTitle("Sign Out", for: .normal)
        SignOutButton.setTitleColor(UIColor.systemRed, for: .normal)
        SignOutButton.titleLabel?.font = .systemFont(ofSize: 14)
        SignOutButton.snp.makeConstraints { make in
            make.top.equalTo(ChangePasswordButton.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
