//
//  ThemeEditor.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 16.02.2022.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                colorChooserSection
                numberOfPairsOfCardsSection
                addEmojisSection
                removeEmojisSection
            }
            .navigationTitle("Edit \"\(theme.name)\"")
        }
    }
    
    // MARK: - Name Section
    
    private var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    // MARK: - Color chooser Section
    
    private var colorChooserSection: some View {
        let color = Binding(
            get: { Color(rgbaColor: self.theme.color) },
            set: { self.theme.color = RGBAColor(color: $0) }
        )
        return Section(header: Text("Color")) {
            ColorPicker("Card color", selection: color)
        }
    }
    
    // MARK: - Number of pairs of cards Section
    
    private var numberOfPairsOfCardsSection: some View {
        Section(header: Text("Number of pairs of cards")) {
            Stepper(
                "Pairs of cards: \(self.theme.numberOfPairsOfCards)",
                value: $theme.numberOfPairsOfCards,
                in: Constants.minNumberOfPairsOfCards...theme.emojis.count
            )
        }
    }
    
    // MARK: - Add / Remove emojis Sections
    
    @State private var emojisToAdd = ""
    
    private var addEmojisSection: some View {
        Section(header: Text("Add emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    theme.emojis = (emojisToAdd + theme.emojis)
                        .filter { $0.isEmoji }
                        .removingDuplicateCharacters
                }
        }
    }
    
    private var removeEmojisSection: some View {
        Section(header: Text("Remove emojis")) {
            ScrollView {
                let emojis = theme.emojis.removingDuplicateCharacters.map { String($0) }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.minVGridItem))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .onTapGesture {
                                theme.emojis.removeAll(where: { String($0) == emoji })
                            }
                    }
                }
                .font(.system(size: Constants.emojiFontSize))
            }
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let minNumberOfPairsOfCards: Int = 2
        static let minVGridItem: CGFloat = 40
        static let emojiFontSize: CGFloat = 40
    }
}
