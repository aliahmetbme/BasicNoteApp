//
//  UserService.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 22.07.2024.
//

import Foundation
import Alamofire

class UserService {
    func getCurrentUser(completion: @escaping ((Result<CurrentUserResponse, NetworkError>) -> Void)) {
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
        
        NetworkManager.shared.request(.me, method: .get, headers: headers,completion: completion)
    }
    
    func updateCurrentUser(currentUser: UserUpdate, completion: @escaping ((Result<UserUpdatedResponse, NetworkError>) -> Void)){
        let parameters = ["full_name": currentUser.full_name, "email": currentUser.email]
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
        
        NetworkManager.shared.request(.updateme, method: .put, parameters: parameters , headers: headers, completion: completion)

    }
    func changePassword(changePasswordStruct: ChangePassword, completion: @escaping ((Result<UserPasswordChangeResponse, NetworkError>) -> Void)){
        let parameters = ["password": changePasswordStruct.password, "new_password": changePasswordStruct.new_password, "new_password_confirmation": changePasswordStruct.new_password_confirmation]
        
        let token = UserDefaults.standard.value(forKey: "accesToken") as! String
        let headers : HTTPHeaders = ["Authorization":"Bearer \(token)" ]
                
        NetworkManager.shared.request(.updatepassword, method: .put, parameters: parameters , headers: headers, completion: completion)
        
    }
}
