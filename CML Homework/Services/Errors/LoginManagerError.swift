//
//  LoginManagerError.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation
import Alamofire

enum LoginManagerError: Error {
    case notAvailable
    case dataIsEmptyError
    case parsingError(error: Error)
    case requestError(error: Error)
    
    func getMessage() -> String {
        switch self {
        case .notAvailable:
            return "Service is not available"
        case .dataIsEmptyError:
            return "Empty data"
        case .parsingError(let error):
            return error.localizedDescription
        case .requestError(let error):
            return error.localizedDescription
        }
    }
}
