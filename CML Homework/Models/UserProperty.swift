//
//  UserProperty.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation

struct UserProperty: Codable {
    let id: Int
    let name: String?
    let description: String?
    let country: String?
    let zipCode: String?
    let state: String?
    let district: String?
    let city: String?
    let street: String?
    let houseNumber: String?
    let suiteNumber: String?
    let coordinates: Coordinates?
    let type: String?
    let status: String?
    let account: String?
    let imageS3Array: [ImageS3]?
    let code: String?
    
    func getStructAsDictionary() -> ([String], [String: String]) {
        var dictionary: [String: String] = [:]
        dictionary["Type"] = self.type
        dictionary["ZIP"] = self.zipCode
        dictionary["Street"] = self.street
        dictionary["Suite No."] = self.suiteNumber
        dictionary["District"] = self.district
        dictionary["House No."] = self.houseNumber
        dictionary["Code"] = self.code
        
        let keys = [String] (dictionary.keys)
        return (keys, dictionary)
    }
}

struct Coordinates: Codable {
    let lat: Double?
    let lng: Double?
}

struct ImageS3: Codable {
    let key: String?
    let temporaryLink: String?
    let description: String?
}
