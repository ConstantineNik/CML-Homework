//
//  LoginError.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

struct LoginError: Codable {
    let httpCode: Int?
    let message: String?
    let exception: String?
}
