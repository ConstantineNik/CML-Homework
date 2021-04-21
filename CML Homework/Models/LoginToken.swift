//
//  LoginResponse.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

struct LoginToken: Codable {
    let accessToken: String
    let tokenType: String
}
