//
//  UserService.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import Foundation
import Alamofire

class UserService {
    func getCurrentUser(completion: @escaping ((Result<CurrentUserResponse, ErrorResponse>) -> Void)) {
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
        
        NetworkManager.shared.request(.me, method: .get, headers: headers,completion: completion)
    }
    
    func updateCurrentUser(currentUser: UserUpdate, completion: @escaping ((Result<UserUpdatedResponse, ErrorResponse>) -> Void)){
        let parameters = ["full_name": currentUser.fullName, "email": currentUser.email]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
        
        NetworkManager.shared.request(.updateme, method: .put, parameters: parameters , headers: headers, completion: completion)

    }
    func changePassword(changePasswordStruct: ChangePassword, completion: @escaping ((Result<UserPasswordChangeResponse, ErrorResponse>) -> Void)){
        let parameters = ["password": changePasswordStruct.password, "new_password": changePasswordStruct.newPassword, "new_password_confirmation": changePasswordStruct.newPasswordConfirmation]
        
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
                
        NetworkManager.shared.request(.updatepassword, method: .put, parameters: parameters , headers: headers, completion: completion)
        
    }
}
