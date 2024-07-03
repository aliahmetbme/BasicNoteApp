//
//  LoginViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 2.07.2024.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var goRegisterPageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goRegisterPageButton.setAttributedTitle(part1: "New User? ", color1: UIColor.black, part2: "Sign up now", color2: UIColor.signuptext, for: .normal)

    }

    @IBAction func goRegisterPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
