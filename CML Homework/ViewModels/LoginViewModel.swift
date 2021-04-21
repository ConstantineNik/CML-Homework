//
//  LoginViewModel.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

protocol LoginViewModelProtocol {
    func logIn(completion: @escaping () -> Void)
}

class LoginViewModel: NSObject, LoginViewModelProtocol {
    
    var apiManager: APIManager
    
    override init() {
        self.apiManager = APIManager()
        
        super.init()
    }
    
    func logIn(completion: @escaping () -> Void) {
        apiManager.performLogIn { [weak self] (result) in
            
            switch result {
            case .success:
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
