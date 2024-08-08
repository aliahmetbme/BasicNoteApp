//
//  ProfileScreenViewModel.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 7.08.2024.
//

import Foundation

protocol IProfileScreenViewModel {
    func singOut()
    func updateCurrentUser()
    func getCurrentUser()
}

class ProfileScreenViewModel: IProfileScreenViewModel {
    let userService = UserService()
    
    var fullName: String = ""
    var email: String = ""

    var onSuccesCurrentUser: ((UserData) -> Void)?
    var onErrorCurrentUser: ((String) -> Void)?
    var onSuccesUpdateCurrentUser: ((String) -> Void)?
    
    func singOut() {
        UserDefaults.standard.removeObject(forKey: "accesToken")
    }
    
    func updateCurrentUser() {
        let currentUser = UserUpdate(fullName: fullName, email: email)
        
        userService.updateCurrentUser(currentUser: currentUser) { response in
            switch response {
            case .success(let response):
                self.onSuccesUpdateCurrentUser?("Succesfully Updated  \(response.message)")
            case .failure(let error):
                self.onErrorCurrentUser?(error.localizedDescription)
            }
        }
    }
    
    func getCurrentUser() {
        userService.getCurrentUser { [self] result in
            switch result {
            case .success(let response):
                self.onSuccesCurrentUser?(response.data)
            case .failure(let error):
                self.onErrorCurrentUser?(error.localizedDescription)
            }
        }
    }
}
