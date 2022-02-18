//
//  EmojiMemoryGame.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 14.01.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.map { String($0) }.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            //String(theme.emojis[theme.emojis.index(theme.emojis.startIndex, offsetBy: pairIndex )])
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    let theme: Theme
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var isAllCardsMatched: Bool {
        for card in model.cards {
            if !card.isMatched {
                return false
            }
        }
        return true
    }
    
    init(with theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    var score: Int {
        model.score
    }
}
