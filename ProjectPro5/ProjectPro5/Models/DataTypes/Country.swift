//
//  Country.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import Foundation

struct Country : Codable {
    let name: CountryName
    let flags: FlagPng
//    let capital: String
    let population: Int
}

struct CountryName : Codable{
    let common: String
    let official: String
}

struct FlagPng: Codable {
    let png: String
}
