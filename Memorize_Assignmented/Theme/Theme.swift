//
//  Theme.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 14.02.2022.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var emojis: String
    var numberOfPairsOfCards: Int
    var color: RGBAColor
    let id: Int
    
    init(name: String, emojis: String, numberOfPairsOfCards: Int, color: RGBAColor, id: Int) {
        self.name = name
        self.emojis = emojis
        if numberOfPairsOfCards > emojis.count || numberOfPairsOfCards <= 0 {
            self.numberOfPairsOfCards = emojis.count
        } else {
            self.numberOfPairsOfCards = numberOfPairsOfCards
        }
        self.color = color
        self.id = id
    }
}

struct RGBAColor: Codable, Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
}
