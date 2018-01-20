//
//  ViewController.swift
//  Set
//
//  Created by Steve Harski on 1/17/18.
//  Copyright © 2018 Steve Harski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Set(numbers: numbers, symbols: symbols, shadings: shadings, colors: colors)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func selectCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            let selectedCard = game.cardsDeck[cardNumber]
            if !game.selectedCards.contains(selectedCard) && game.selectedCards.count < 3 {
                sender.layer.borderWidth = 3.0
                sender.layer.borderColor = UIColor.blue.cgColor
                sender.layer.cornerRadius = 8.0
            } else {
                sender.layer.borderWidth = 0.0
                sender.layer.borderColor = UIColor.white.cgColor
                sender.layer.cornerRadius = 0.0
            }
            game.chooseCard(at: cardNumber)
        }

        
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
            if index < game.playedCards.count {
                let card = game.playedCards[index]
                let attributes = getAttributes(shading: card.shading, color: card.color)
                let attributedText = NSAttributedString(string: card.symbol, attributes: attributes)
                button.setAttributedTitle(attributedText, for: .normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.setTitle("", for: .normal)
            }
        }
    }

    let numbers = [1, 2, 3]
    let symbols = ["▲", "●", "■"]
    let shadings =  ["solid", "stripped", "open"]
    let colors: [UIColor] = [.red, .green, .purple]
    
    
    private func getAttributes(shading: String, color: UIColor) -> [NSAttributedStringKey : Any] {
        let strokeWidth = (shading == "open") ? 5.0 : -5.0
        let alpha = (shading == "stripped") ? 0.15 : 1
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeWidth : strokeWidth,
            NSAttributedStringKey.foregroundColor : UIColor.withAlphaComponent(color)(CGFloat(alpha))]
        return attributes
    }
    
}

