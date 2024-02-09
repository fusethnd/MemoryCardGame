//
//  MemoryGameModel.swift
//  MemoryGame
//
//  Created by Thanadon Boontawee on 2/2/2567 BE.
//

import Foundation

struct MemoryGameModel<CardContentType :Equatable> {
    private(set) var cards: Array<Card>
    // private(set) can only read but can't write
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
            // append emoji cards 2 times for pair
        }
        shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?
    private mutating func faceDownAll() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    mutating func choose(_ card: Card) { // _ meam dont have to write name when use this function
        let chosenIndex = index(of: card)
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                faceDownAll()
            }
            cards[chosenIndex].isFaceUp = true
        }
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
    
    struct Card: Identifiable, Equatable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContentType
        let id = UUID()
    }
}
