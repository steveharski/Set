//
//  ViewController.swift
//  Set
//
//  Created by Steve Harski on 1/17/18.
//  Copyright © 2018 Steve Harski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func selectCard(_ sender: UIButton) {
        sender.layer.borderWidth = 3.0
        sender.layer.borderColor = UIColor.blue.cgColor
        sender.layer.cornerRadius = 8.0
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        print(#function)
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < 12 {
                
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.setTitle("", for: .normal)
            }
        }
    }
    
    
    
}

