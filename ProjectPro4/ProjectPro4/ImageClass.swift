//
//  ImageClass.swift
//  ProjectPro4
//
//  Created by Chingiz on 22.01.24.
//

import Foundation

class ImageClass: NSObject, NSCoding{
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        imageName = aDecoder.decodeObject(forKey: "imageName") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(imageName, forKey: "imageName")
    }
    
}
