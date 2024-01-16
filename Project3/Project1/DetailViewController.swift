//
//  DetailViewController.swift
//  Project1
//
//  Created by Chingiz on 16.01.24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewDetail: UIImageView!
    
    
    var selectedImage: String?
    var positionInArray: Int?
    var totalOfImages: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let xNum = positionInArray, let yNum = totalOfImages{
            title = "Pictures \(xNum) of \(yNum)"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
       
        if let image = selectedImage {
            imageViewDetail.image = UIImage(named: image)
        }
        
    }
    override class func description() -> String {
        return "DetailViewController"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageViewDetail.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
        
    
}
