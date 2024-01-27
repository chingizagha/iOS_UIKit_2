//
//  ViewController.swift
//  Project18
//
//  Created by Chingiz on 27.01.24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "")
        
        assert(1 == 1, "Maths failure!")
        assert(1 == 2, "Maths failure!")
    }


}

