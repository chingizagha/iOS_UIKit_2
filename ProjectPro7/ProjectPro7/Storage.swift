//
//  Storage.swift
//  ProjectPro7
//
//  Created by Chingiz on 31.01.24.
//

import Foundation

class Storage{
    
    static let notesKey = "notes"
    
    static func load() -> [Note]{
        let defaults = UserDefaults.standard
        var notes = [Note]()
        
        if let savedData = defaults.object(forKey: notesKey) as? Data {
            let jsonDecoder = JSONDecoder()
            notes = (try? jsonDecoder.decode([Note].self, from: savedData)) ?? notes
        }
        return notes
    }
    
    static func save(notes: [Note]) {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: notesKey)
        }
    }
}
