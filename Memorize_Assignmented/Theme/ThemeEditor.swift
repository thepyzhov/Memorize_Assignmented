//
//  ThemeEditor.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 16.02.2022.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(theme: Binding<Theme>) {
        self._theme = theme
        self._name = State(initialValue: theme.wrappedValue.name)
        self._numberOfPairsOfCards = State(initialValue: theme.wrappedValue.numberOfPairsOfCards)
        self._color = State(initialValue: Color(rgbaColor: theme.wrappedValue.color))
        self._emojis = State(initialValue: theme.wrappedValue.emojis)
        
        // Temporary variables
        self._emojisToAdd = State(initialValue: "")
        self._emojisToRemove = State(initialValue: "")
    }
    
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
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    doneButton
                }
            }
        }
    }
    
    // MARK: - Navigation View Bar Buttons
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            saveChanges()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func saveChanges() {
        theme.name = name
        theme.numberOfPairsOfCards = numberOfPairsOfCards
        theme.color = RGBAColor(color: color)
        theme.emojis = emojis
    }
    
    // MARK: - Name Section
    
    @State private var name: String
    
    private var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $name)
        }
    }
    
    // MARK: - Color chooser Section
    
    @State private var color: Color
    
    private var colorChooserSection: some View {
        Section(header: Text("Color")) {
            ColorPicker("Card color", selection: $color)
        }
    }
    
    // MARK: - Number of pairs of cards Section
    
    @State private var numberOfPairsOfCards: Int
    
    private var numberOfPairsOfCardsSection: some View {
        Section(header: Text("Number of pairs of cards")) {
            Stepper(
                "Pairs of cards: \(numberOfPairsOfCards)",
                value: $numberOfPairsOfCards,
                in: Constants.minNumberOfPairsOfCards...emojis.count
            )
        }
    }
    
    // MARK: - Add / Remove emojis Sections
    
    @State private var emojis: String {
        didSet {
            numberOfPairsOfCards = emojis.count
        }
    }
    @State private var emojisToAdd: String
    
    private var addEmojisSection: some View {
        Section(header: Text("Add emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    self.emojis = (emojisToAdd + self.emojis)
                        .filter { $0.isEmoji }
                        .removingDuplicateCharacters
                }
        }
    }
    
    @State private var emojisToRemove: String
    
    private var removeEmojisSection: some View {
        Section(header: Text("Remove emojis")) {
            ScrollView {
                let emojis = self.emojis.removingDuplicateCharacters.map { String($0) }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.minVGridItem))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .onTapGesture {
                                if emojis.count > Constants.minNumberOfPairsOfCards {
                                    self.emojis.removeAll(where: { String($0) == emoji })
                                }
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
