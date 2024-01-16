//
//  DetailViewController.swift
//  ProjectPro1
//
//  Created by Chingiz on 16.01.24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageNameFull = imageName{
            title = imageNameFull.uppercased()
            imageView.image = UIImage(named: imageNameFull)
        }
        
        imageView.layer.borderWidth = 1
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
    }
    
    
    override class func description() -> String {
        return "DetailViewController"
    }
    
    @objc func sharePressed() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("No Image Found")
            return
        }
        
        guard let name = imageName else{
            print("No Name Found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, name], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
