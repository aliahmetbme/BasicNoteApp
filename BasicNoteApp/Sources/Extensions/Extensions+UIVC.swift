//
//  Extensions@+UINavigationBarItem.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 10.07.2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBackButtonItemTitle (title:String = "") {
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.navigationItem.backBarButtonItem = backButton
    }
}
