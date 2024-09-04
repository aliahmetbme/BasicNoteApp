//
//  ViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit
import Alamofire
import SnapKit

// why final
final class RegisterViewController: UIViewController {
    
    private var FullNameField = UITextField()
    private var EmailAddressField = UITextField()
    private var PasswordField = UITextField()
    
    private var RegisterButton = UIButton()
    private var LoginButton = UIButton()
    
    private var SignUpLablel = UILabel()
    private var SignUpMessageLablel = UILabel()
    private var ErrorMessage = UILabel()
    private var ErrorImage = UIImageView()
    
    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackButtonTitle()
    }
    
    private func initialSettigs () {
        makeFullNameLabel()
        makeEmailAdressLabel()
        makePassWordLabel()
        ErrorImage.isHidden = true
        ErrorMessage.isHidden = true
    }
    
    private func configure() {
        view.addSubview(SignUpLablel)
        view.addSubview(SignUpMessageLablel)
        view.addSubview(FullNameField)
        view.addSubview(EmailAddressField)
        view.addSubview(PasswordField)
        view.addSubview(RegisterButton)
        view.addSubview(LoginButton)
        view.addSubview(ErrorMessage)
        view.addSubview(ErrorImage)
        
        EmailAddressField.delegate = self
        FullNameField.delegate = self
        PasswordField.delegate = self

        makeSignUpLabel()
        makeSignUpMessageLabel()
        makeFullNameLabel()
        makeEmailAdressLabel()
        makePassWordLabel()
        makeErrorImage()
        makeErrorLabel()
        makeRegisterButton()
        makeGoLoginPageButton()
        
        RegisterButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        LoginButton.addTarget(self, action: #selector(goLoginPage), for: .touchUpInside)
    }
    
}

// Actions
extension RegisterViewController {
    
    @objc private func register() {
        initialSettigs()
        
        let user = UserRegister(password: PasswordField.text! , email: EmailAddressField.text! , fullName: FullNameField.text!)
        
        authService.register(user: user) { result in
            switch result {
            case .success(let response):
                print(response)
                self.performSegue(withIdentifier: "goLoginPage", sender: nil)
            case .failure(let error):
                self.EmailAddressField.showInvalidFunctionError()
                self.FullNameField.showInvalidFunctionError()
                self.PasswordField.showInvalidFunctionError()
                self.ErrorImage.isHidden = false
                self.ErrorMessage.text = error.localizedDescription
                self.ErrorMessage.isHidden = false
            }
        }
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
        print(EmailAddressField.isValidEmail(email: EmailAddressField.text!))

    }
}

// Initial UI Programatic Coding
extension RegisterViewController {
    
    private func makeSignUpLabel () {
        SignUpLablel.text = "Sign Up"
        SignUpLablel.font = .boldSystemFont(ofSize: 26)
        SignUpLablel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(96)
            make.centerX.equalToSuperview()
        }
    }
    
    private func makeSignUpMessageLabel () {
        SignUpMessageLablel.text = "Login or sign up to continue using our app."
        SignUpMessageLablel.textColor = .lightGray
        SignUpMessageLablel.font = .systemFont(ofSize: 15, weight: .medium)
        SignUpMessageLablel.snp.makeConstraints { make in
            make.top.equalTo(SignUpLablel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func makeFullNameLabel () {
        FullNameField.placeholder = "Full Name"
        FullNameField.initialDesign()
        FullNameField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(SignUpMessageLablel.snp.bottom).offset(16)
        }
    }

    private func makeEmailAdressLabel () {
        EmailAddressField.placeholder = "Email Adress"
        EmailAddressField.initialDesign()
        EmailAddressField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(FullNameField.snp.bottom).offset(16)
        }
    }

    private func makePassWordLabel () {
        PasswordField.placeholder = "Password"
        PasswordField.initialDesign()
        PasswordField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(EmailAddressField.snp.bottom).offset(16)
        }
    }

    private func makeErrorLabel () {
        ErrorMessage.text = "Error"
        ErrorMessage.textColor = UIColor.error
        ErrorMessage.isHidden = true
        
        ErrorMessage.font = .systemFont(ofSize: 12)
        ErrorMessage.snp.makeConstraints { make in
            make.top.equalTo(PasswordField.snp.bottom).offset(8)
            make.left.equalTo(ErrorImage.snp.right).offset(5)
            make.centerY.equalTo(ErrorImage)
        }
    }

    private func makeErrorImage () {
        ErrorImage.image = .erroricon
        ErrorImage.frame.size.width = 32
        ErrorImage.isHidden = true
        
        ErrorImage.snp.makeConstraints { make in
            make.top.equalTo(PasswordField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 20, height: 20)) // Boyutu ayarla

        }
    }
    
    private func makeRegisterButton() {
        RegisterButton.setTitle("Sign Up", for: .normal)
        RegisterButton.isEnabled = false

        RegisterButton.initialDesign()
        RegisterButton.makeRadius()
        
        RegisterButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.equalTo(63)
            make.top.equalTo(ErrorMessage.snp.bottom).offset(20)
        }
    }

    private func makeGoLoginPageButton() {
        LoginButton.setAttributedTitle(part1: "Already have an Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
        LoginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

// Text View Handling
extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkShouldEnableToRegisterButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkShouldEnableToRegisterButton()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkShouldEnableToRegisterButton()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        checkShouldEnableToRegisterButton()
        return true
    }
        
    private func checkShouldEnableToRegisterButton() {
        if (EmailAddressField.text == "" || FullNameField.text == "" || PasswordField.text == "") {
            RegisterButton.isEnabled = false
        } else {
            RegisterButton.isEnabled = true
        }
        RegisterButton.initialDesign()
    }
}
