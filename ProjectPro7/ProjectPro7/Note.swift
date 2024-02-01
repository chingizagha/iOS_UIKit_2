//
//  Note.swift
//  ProjectPro7
//
//  Created by Chingiz on 31.01.24.
//

import Foundation

class Note: Codable{
    var text: String
    var date: Date
    
    init(text: String, date: Date) {
        self.text = text
        self.date = date
    }
}
