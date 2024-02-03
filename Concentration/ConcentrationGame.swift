//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Булат Камалетдинов on 31.05.2023.
//

import Foundation


class ConcentrationGame {
    
    static var matches = 0
    static var flips = 0
    var cards = [Card]()
    var indexOfAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if !cards[index].isFaceUp { ConcentrationGame.flips += 1 }
            if let matchingIndex = indexOfAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                    ConcentrationGame.matches += 1
                }
                cards[index].isFaceUp = true
                indexOfAndOnlyFaceUpCard = nil
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
}
