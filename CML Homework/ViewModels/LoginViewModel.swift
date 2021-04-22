//
//  LoginViewModel.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

protocol LoginViewModelProtocol {
    func logIn(email: String, password: String, completion: @escaping (LoginResult) -> Void)
}

class LoginViewModel: NSObject, LoginViewModelProtocol {
    
    var apiManager: APIManager
    
    override init() {
        self.apiManager = APIManager()
        super.init()
    }
    
    func logIn(email: String, password: String, completion: @escaping (LoginResult) -> Void) {
        apiManager.performLogIn(email: email, password: password) { (result) in
            completion(result)
        }
    }
}
