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
        updateViewFromModel()
        if let cardNumber = cardButtons.index(of: sender) {
            guard (game.playedCards[safe: cardNumber] as Card?) != nil
                else { return }
            game.chooseCard(at: cardNumber)
            
            for playedCard in game.playedCards {
                if let playedCardIndex = game.playedCards.index(of: playedCard) {
                    if game.selectedCards.contains(playedCard) {
                        if game.selectedCards.count == 3 {
                            // Mismatch
                            cardButtons[playedCardIndex].layer.borderWidth = 3.0
                            cardButtons[playedCardIndex].layer.borderColor = UIColor.red.cgColor
                            cardButtons[playedCardIndex].layer.cornerRadius = 8.0
                        } else {
                            // Selected card
                            cardButtons[playedCardIndex].layer.borderWidth = 3.0
                            cardButtons[playedCardIndex].layer.borderColor = UIColor.blue.cgColor
                            cardButtons[playedCardIndex].layer.cornerRadius = 8.0
                        }
                    } else if game.matchedCards.contains(playedCard) {
                        // Match
                        cardButtons[playedCardIndex].layer.borderWidth = 3.0
                        cardButtons[playedCardIndex].layer.borderColor = UIColor.green.cgColor
                        cardButtons[playedCardIndex].layer.cornerRadius = 8.0
                    } else {
                        // Default
                        cardButtons[playedCardIndex].layer.borderWidth = 0.0
                        cardButtons[playedCardIndex].layer.borderColor = UIColor.white.cgColor
                        cardButtons[playedCardIndex].layer.cornerRadius = 0.0
                    }
                }

            }
        }
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        game.dealThreeMoreCards()
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Set(numbers: numbers, symbols: symbols, shadings: shadings, colors: colors)
        updateViewFromModel()
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
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

