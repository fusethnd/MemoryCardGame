//
//  MemoryGameModel.swift
//  MemoryGame
//
//  Created by Thanadon Boontawee on 2/2/2567 BE.
//

import Foundation

struct MemoryGameModel<CardContentType> {
    private(set) var cards: Array<Card>
    // private(set) can only read but can't write
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        shuffle()
    }
    
    mutating func choose(_ card: Card) { // _ meam dont have to write name when use this function
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    private func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContentType
        let id = UUID()
    }
}
