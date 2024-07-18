//
//  ViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 1.07.2024.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet private var fullNameLabel: UITextField!
    @IBOutlet private var emailAdressLabel: UITextField!
    @IBOutlet private private var passwordLabel: UITextField!
    @IBOutlet private private var registerButton: UIButton!
    @IBOutlet private private var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalDesign()
    }
    
    private func initalDesign () {
        
        fullNameLabel.initialDesign()
        emailAdressLabel.initialDesign()
        passwordLabel.initialDesign()
        registerButton.disabledDesign()

        loginButton.setAttributedTitle(part1: "Already have Account?", color1: UIColor.black, part2: " Sign in now", color2: UIColor.signuptext, for: .normal)
    
        setBackButtonItemTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

// Actions
extension RegisterViewController {
    
    @IBAction private func register(_ sender: Any) {
        let parameters = UserRegister(password: passwordLabel.text! , email: emailAdressLabel.text! , full_name: fullNameLabel.text!)
        
        AF.request("\(ApiBaseUrlConfig.apiBaseUrl)\(RequestTypeConfig.register)", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).response {response in
            
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                } catch {
                    print("error")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction private func goLoginPage(_ sender: Any) {
        performSegue(withIdentifier: "goLoginPage", sender: nil)
    }
}
