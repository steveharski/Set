//
//  Set.swift
//  Set
//
//  Created by Steve Harski on 1/19/18.
//  Copyright © 2018 Steve Harski. All rights reserved.
//

import UIKit

struct Set {
    
    private(set) var cardsDeck = [Card]()
    private(set) var playedCards = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var matchedCards = [Card]()
    
    mutating func chooseCard(at index: Int) {
        assert(cardsDeck.indices.contains(index), "Set.chooseCard(at index:\(index): chosen index not in the deck")
        let selectedCard = cardsDeck[index]
        if !selectedCards.contains(selectedCard) && selectedCards.count < 2 {
            selectedCards.append(cardsDeck[index])
        } else if selectedCards.contains(selectedCard) && selectedCards.count < 3 {
            // Deselect
            let index = selectedCards.index(of: selectedCard)
            selectedCards.remove(at: index!)
        } else {
            // Check for Set
            let firstComparison = compareQualities(card1: selectedCards[0], card2: selectedCards[1])
            let secondComparison = compareQualities(card1: selectedCards[0], card2: selectedCard)
            let thirdComparison = compareQualities(card1: selectedCards[1], card2: selectedCard)
            if firstComparison == secondComparison && secondComparison == thirdComparison {
                print("SET!")
                // In UI mark with green last 3 cards from matchedCards
                // Insert 3 new cards into played cards at the the index of matched
               // playedCards.insert(cardsDeck.removeFirst(), at: playedCards.index(of: selectedCard)!)
                matchedCards.append(selectedCard)
                matchedCards.append(selectedCards.removeFirst())
                matchedCards.append(selectedCards.removeFirst())
            } else {
                print("NOT SET!")
                // In UI mark with red mismatched cards
            }
        }
    }
    
    private func compareQualities(card1: Card, card2: Card) -> [Bool] {
        let symbolResult = card1.symbol == card2.symbol
        let colorResult = card1.color == card2.color
        let shadingResult = card1.shading == card2.shading
        let numberResult = card1.symbol.count == card2.symbol.count
        return [symbolResult, colorResult, shadingResult, numberResult]
    }
    
    init(numbers: [Int], symbols: [String], shadings: [String], colors: [UIColor]) {
        for number in numbers {
            for symbol in symbols {
                for shading in shadings {
                    for color in colors {
                        let card = Card(symbol: String.multiplyString(repeatedString: symbol, numberOfRepeats: number), shading: shading, color: color)
                        cardsDeck.append(card)
                    }
                }
            }
        }
        // Shuffle the cards
        for cardIndex in 1..<cardsDeck.count {
            let index = Int(arc4random_uniform(UInt32(cardsDeck.count - 1)))
            cardsDeck.swapAt(cardIndex, index)
        }
        // Deal first 12 cards
        for _ in 0..<12 {
            playedCards.append(cardsDeck.removeFirst())
        }
    }
}

extension String {
    static func multiplyString(repeatedString: String, numberOfRepeats: Int) -> String {
        var newString = ""
        for _ in 1...numberOfRepeats {
            newString += repeatedString
        }
        return newString
    }
}
