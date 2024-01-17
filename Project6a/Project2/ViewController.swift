//
//  ViewController.swift
//  Project2
//
//  Created by Chingiz on 16.01.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!

    @IBOutlet weak var labelScore: UILabel!
    
    var countries = [String]()
    var score = 0
    var correntAnswer = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy",
        "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        btnOne.layer.borderWidth = 1
        btnTwo.layer.borderWidth = 1
        btnThree.layer.borderWidth = 1
        
        
        
        askQuestion()
        
        labelScore.text = "Score: 0"
    }
    
    func askQuestion() {
        countries.shuffle()
        
        correntAnswer = Int.random(in: 0...2)
        
        btnOne.setImage(UIImage(named: countries[0]), for: .normal)
        btnTwo.setImage(UIImage(named: countries[1]), for: .normal)
        btnThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correntAnswer].uppercased()
    }
   
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if UIImage(named: countries[correntAnswer]) == sender.currentImage {
            score += 1
            askQuestion()
            labelScore.text = "Score: \(score)"
        }
        else {
            askQuestion()
        }
    }

    
    
    


}

