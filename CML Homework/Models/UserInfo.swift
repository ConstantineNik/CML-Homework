//
//  UserInfo.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

struct UserInfo: Codable {
    let id: Int
    let email: String
    let emailVerified: Bool
    let firstName: String?
    let lastName: String?
    let phone: String?
    let avatar: Avatar?
    let accountId: Int?
    let role: String?
}

struct Avatar: Codable {
    let s3Key: String?
    let s3Link: String?
}
