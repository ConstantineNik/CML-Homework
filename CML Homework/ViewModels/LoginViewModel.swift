//
//  LoginViewModel.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

protocol LoginViewModelProtocol {
    func logIn(email: String, password: String, completion: @escaping () -> Void)
    func textFieldValidation(email: String, password: String) -> Valid
}

class LoginViewModel: NSObject, LoginViewModelProtocol {
    
    var apiManager: APIManager
    
    override init() {
        self.apiManager = APIManager()
        
        super.init()
    }
    
    func textFieldValidation(email: String, password: String) -> Valid {
        return Validation.shared.validate(values: (ValidationType.email, email), (ValidationType.password, password))
    }
    
    func logIn(email: String, password: String, completion: @escaping () -> Void) {
        apiManager.performLogIn(email: email, password: password) { [weak self] (result) in
            
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
