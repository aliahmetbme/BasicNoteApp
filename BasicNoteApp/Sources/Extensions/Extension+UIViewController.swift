//
//  Extension+UIViewController.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func setBackButtonTitle(title: String = "", isHideNavBar: Bool = true) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.navigationBar.isHidden = false
    }
}
