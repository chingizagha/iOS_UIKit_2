//
//  DetailViewController.swift
//  ProjectPro5
//
//  Created by Chingiz on 26.01.24.
//

import UIKit

class DetailViewController: UIViewController {

    var name : String!
    var capital : String!
    var image: UIImage!
    var country: Countries!

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        imageView.image = image
        capitalLabel.text = capital
        nameLabel.text = name
    }
    
    

}
