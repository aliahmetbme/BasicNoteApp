//
//  LoginViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 2.07.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var EmailAdressField = UITextField()
    private var PasswordField = UITextField()
    
    private var LoginButton = UIButton()
    private var GoRegisterPageButton = UIButton()
    private var ForgetPasswordButton = UIButton()
    
    private var LoginLablel = UILabel()
    private var LoginMessageLablel = UILabel()
    private var ErrorMessage = UILabel()
    
    private var ErrorImage = UIImageView()
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDesign()
        initialSettings()
        setupBinding()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialDesign()
        setupBinding()
    }
    
    private func configuration () {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(LoginLablel)
        view.addSubview(LoginMessageLablel)
        view.addSubview(EmailAdressField)
        view.addSubview(PasswordField)
        view.addSubview(ErrorImage)
        view.addSubview(ErrorMessage)
        view.addSubview(ForgetPasswordButton)
        view.addSubview(LoginButton)
        view.addSubview(GoRegisterPageButton)
        
        makeLoginLabel()
        makeLoginMessageLablel()
        makeEmailAdressLabel()
        makePassWordLabel()
        makeErrorImage()
        makeErrorLabel()
        makeForgetPasswordButton()
        makeLoginButton()
        makeGoRegisterPageButton()
        
        LoginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        ForgetPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        GoRegisterPageButton.addTarget(self, action: #selector(goRegisterPage), for: .touchUpInside)

    }
    
    private func initialSettings() {
        EmailAdressField.delegate = self
        PasswordField.delegate = self
    }
    
    private func initialDesign() {
        setBackButtonTitle()
        ErrorMessage.isHidden = true
        ErrorImage.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupBinding() {
        
        viewModel.isValidInput()
        
        viewModel.isLoginButtonEnabled = { isEnabled in
            self.LoginButton.isEnabled = isEnabled
            self.LoginButton.initialDesign()
        }
        
        viewModel.onSucces = {token in
            // bunu sor modelde mi kalmalı yoksa burda mı ?
            UserDefaults.standard.setValue(token, forKey: "accesToken")
            self.navigationController?.pushViewController(NotesScreenViewController(), animated: true)
        }
        
        viewModel.onError = { error in
            self.ErrorMessage.text = error
            self.ErrorMessage.isHidden = false
            self.ErrorImage.isHidden = false
        }
    }
}

// Actions
extension LoginViewController {
    @IBAction private func goRegisterPage(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @IBAction private func forgotPassword(_ sender: Any) {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @IBAction private func login(_ sender: Any) {
        initialDesign()
        viewModel.login()
    }
}

// Initial UI Programatic Coding
extension LoginViewController {
    private func makeLoginLabel () {
        LoginLablel.text = "Login"
        LoginLablel.font = .boldSystemFont(ofSize: 26)
        LoginLablel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(96)
            make.centerX.equalToSuperview()
        }
    }
    
    private func makeLoginMessageLablel () {
        LoginMessageLablel.text = "Login or sign up to continue using our app."
        LoginMessageLablel.textColor = .lightGray
        LoginMessageLablel.font = .systemFont(ofSize: 15, weight: .medium)
        LoginMessageLablel.snp.makeConstraints { make in
            make.top.equalTo(LoginLablel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func makeEmailAdressLabel () {
        EmailAdressField.placeholder = "Email Adress"
        EmailAdressField.initialDesign()
        EmailAdressField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(LoginMessageLablel.snp.bottom).offset(26)
        }
    }

    private func makePassWordLabel () {
        PasswordField.placeholder = "Password"
        PasswordField.initialDesign()
        PasswordField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.greaterThanOrEqualTo(53)
            make.top.equalTo(EmailAdressField.snp.bottom).offset(16)
        }
    }

    private func makeErrorLabel () {
        ErrorMessage.text = "Error"
        ErrorMessage.textColor = UIColor.error
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
        
        ErrorImage.snp.makeConstraints { make in
            make.top.equalTo(PasswordField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 20, height: 20))

        }
    }
    
    private func makeForgetPasswordButton() {
        ForgetPasswordButton.setTitleColor(.black, for: .normal)
        ForgetPasswordButton.setTitle("Forget Password ? ", for: .normal)
        ForgetPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        
        ForgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(PasswordField.snp.bottom).offset(35)
            make.right.equalToSuperview().inset(33)
        }
    }
    
    private func makeLoginButton() {
        LoginButton.setTitle("Login", for: .normal)

        LoginButton.initialDesign()
        LoginButton.makeRadius()
        
        LoginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.height.equalTo(63)
            make.top.equalTo(ForgetPasswordButton.snp.bottom).offset(20)
        }
    }

    private func makeGoRegisterPageButton() {
        GoRegisterPageButton.setAttributedTitle(part1: "New User? ", color1: UIColor.black, part2: "Sign up now", color2: UIColor.signuptext, for: .normal)
        GoRegisterPageButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(33)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

// UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.isValidInput()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateViewModel(textField: textField)
        viewModel.isValidInput()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        updateViewModel(textField: textField)
        viewModel.isValidInput()
        return true
    }
    
    private func updateViewModel(textField: UITextField) {
        switch textField {
        case EmailAdressField:
            viewModel.email = textField.text ?? ""
        case PasswordField:
            viewModel.password = textField.text ?? ""
        default:
            break
        }
    }
}
