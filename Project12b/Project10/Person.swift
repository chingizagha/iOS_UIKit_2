//
//  Person.swift
//  Project10
//
//  Created by Chingiz on 21.01.24.
//

import UIKit

class Person: NSObject, Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    	

}
