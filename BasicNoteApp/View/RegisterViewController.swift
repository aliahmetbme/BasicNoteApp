//
//  ViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var fullNameLabel: UITextField!
    @IBOutlet var emailAdressLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.initialDesign()
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        
        registerButton.disabledDesign()
        loginButton.setAttributedTitle(part1: "Already have Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func register(_ sender: Any) {
        // kayıt işlemleri hata durumu vb. 
        passwordLabel.showInvalidFunctionError(message: "Password Invalid")
    }
    
    @IBAction func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
    }
}

