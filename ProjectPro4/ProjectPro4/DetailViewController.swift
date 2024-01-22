//
//  DetailViewController.swift
//  ProjectPro4
//
//  Created by Chingiz on 22.01.24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name: String?
    var imageName: String?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = name
        let path = getDocumentDirectory().appendingPathComponent(imageName ?? "")
        imageView.image = UIImage(contentsOfFile: path.path)
        
    }

    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override class func description() -> String {
        return "DetailViewController"
    }


}
