//
//  Memorize_AssignmentedApp.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 11.01.2022.
//

import SwiftUI

@main
struct Memorize_AssignmentedApp: App {
    //@StateObject var game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser()
                .environmentObject(themeStore)
        }
    }
}
