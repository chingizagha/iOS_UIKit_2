//
//  Countries.swift
//  ProjectPro5
//
//  Created by Chingiz on 26.01.24.
//

import Foundation

struct Countries : Codable {
    var name: CountryName
    var flags: FlagPng
    var capital: [String]
}

struct CountryName : Codable{
    var common: String
}

struct FlagPng: Codable {
    var png: String
}
