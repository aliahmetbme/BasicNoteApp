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
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setBackButtonTitle(title: "Profile",isHideNavBar: false)
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
        
        ChangePasswordButton.addTarget(self, action: #selector(goChangePasswordPage), for: .touchUpInside)
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
    
    @objc func returnNotesPage() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accesToken")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func goChangePasswordPage(_ sender: Any) {
        navigationController?.pushViewController(PasswordChangeScreenViewController(), animated: true)
    }
    
    @objc func saveChanges(_ sender: Any) {
        
        let currentUser = UserUpdate(fullName: FullNameField.text!, email: EmailAdressField.text!)
        
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
