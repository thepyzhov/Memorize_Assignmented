//
//  ThemeChooser.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 17.01.2022.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    @State private var games = [Theme:EmojiMemoryGame]()
    @State private var editMode: EditMode = .inactive
    
    @State private var inEditMode = false
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: getGame(with: theme)) {
                        navigationItemBody(for: theme)
                    }
                    .gesture(editMode == .active ? tapToEditItem(for: theme) : nil)
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
            }
            .popover(item: $themeToEdit) { theme in
                NavigationView {
                    ThemeEditor(theme: $store.themes[theme])
                        .navigationTitle("Edit \"\(theme.name)\"")
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    // MARK: - Gestures
    
    private func tapToEditItem(for theme: Theme) -> some Gesture {
        TapGesture()
            .onEnded {
                themeToEdit = theme
            }
    }
    
    // MARK: - Views
    
    private func navigationItemBody(for theme: Theme) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(theme.name).bold()
                Text("(\(theme.numberOfPairsOfCards) pairs)")
            }
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 10).fill(Color(rgbaColor: theme.color)).frame(idealWidth: 30, idealHeight: 30).fixedSize()
                Text(theme.emojis)
                    .lineLimit(1)
            }
        }
    }
    
    private func getGame(with theme: Theme) -> some View {
        if games[theme] == nil {
            let newGame = EmojiMemoryGame(with: theme)
            games.updateValue(newGame, forKey: theme)
            return EmojiMemoryGameView(game: newGame)
        }
        return EmojiMemoryGameView(game: games[theme]!)
    }
}

//struct ThemeChooser_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeChooser()
//    }
//}
