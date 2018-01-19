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
