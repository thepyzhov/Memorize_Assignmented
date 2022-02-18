//
//  ThemeStore.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 13.02.2022.
//

import SwiftUI

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            saveInUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        loadFromUserDefaults()
        
        if themes.isEmpty {
            insertTheme(
                named: "Vehicles",
                emojis: "🚗🚕🚌🚎🏎🚓🚑🚐🚒🚚🚜🚘🚖🚅🚃✈️🚁🛶🛥🛳⛴🚢🚡🚠",
                color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
            )
            insertTheme(
                named: "Food",
                emojis: "🍏🍊🍋🍉🍓🍒🍍🥥🥝🍅🍆🥑🥦🌶🌽🥕🧄🧅🥐🥔🍞🥖🧀",
                color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
            )
            insertTheme(
                named: "Flags",
                emojis: "🏳️🏴🏁🇦🇽🇦🇱🇦🇴🇦🇮🇦🇲🇦🇺🇦🇹🇧🇪🇧🇸🇧🇾🇧🇭🇧🇯🇧🇴🇧🇦🇧🇼🇧🇷🇧🇳🇨🇦🇩🇰",
                color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
            )
            insertTheme(
                named: "Sport",
                emojis: "⚽️🏀🏈🏸🏏⛷⛸🥋⛳️🥊🥇🏆",
                color: Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))
            )
            insertTheme(
                named: "Tech",
                emojis: "📱⌨️💻🕹💿💾🖨🖥📼📷☎️📺📻⏰🔦",
                color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
            )
            insertTheme(
                named: "Green",
                emojis: "🦚🐉🌵🌲🌳🌴🌿🌱☘️🍀🪴🍃",
                color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
            )
        } else {
            print("Themes loaded from UserDefaults: \(themes)")
        }
    }
    
    // MARK: - User Defaulst
    
    private var userDefaulstKey: String {
        "ThemeStore" + name
    }
    
    private func saveInUserDefaults() {
        UserDefaults.standard.setValue(try? JSONEncoder().encode(themes), forKey: userDefaulstKey)
    }
    
    private func loadFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaulstKey),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    // MARK: - Intent(s)
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: String, numberOfPairsOfCards: Int = 0, color: Color, at index: Int = 0) {
        let uniqueID = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let color = RGBAColor(color: color)
        let theme = Theme(name: name, emojis: emojis, numberOfPairsOfCards: numberOfPairsOfCards, color: color, id: uniqueID)
        let safeIndex = min(max(0, index), themes.count)
        themes.insert(theme, at: safeIndex)
        
    }
}
