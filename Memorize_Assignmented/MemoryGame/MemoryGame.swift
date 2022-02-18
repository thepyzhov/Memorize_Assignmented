//
//  MemoryGame.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 14.01.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards = [Card]()
    private(set) var score = 0
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasAlreadyBeenSeen = false
        var content: CardContent
        let id: Int
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasAlreadyBeenSeen || cards[potentialMatchIndex].hasAlreadyBeenSeen {
                        score = score - 1 < 0 ? 0 : score - 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            //cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set {
            cards.indices.forEach {
                cards[$0].hasAlreadyBeenSeen = $0 == newValue
                cards[$0].isFaceUp = $0 == newValue
            }
            
        }
    }
}

extension Array {
    var oneAndOnly: Element? { count == 1 ? first : nil }
}
