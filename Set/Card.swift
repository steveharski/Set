//
//  Card.swift
//  Set
//
//  Created by Steve Harski on 1/19/18.
//  Copyright © 2018 Steve Harski. All rights reserved.
//

import UIKit

struct Card: Equatable {
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isMatched = false // not sure
    
    var symbol: String
    var shading: String
    var color: UIColor
    
    var identifier: Int
    
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(symbol: String, shading: String, color: UIColor) {
        self.identifier = Card.getUniqueIdentifier()
        self.symbol = symbol
        self.shading = shading
        self.color = color
    }
}
