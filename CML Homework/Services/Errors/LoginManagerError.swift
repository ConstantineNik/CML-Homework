//
//  LoginManagerError.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

enum LoginManagerError: Error {
    case notAvailable
    case dataIsEmptyError
    case parsingError(error: Error)
}
