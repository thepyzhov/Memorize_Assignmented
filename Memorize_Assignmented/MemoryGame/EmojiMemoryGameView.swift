//
//  ContentView.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 11.01.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            header
            Spacer()
            if !game.isAllCardsMatched {
                cardTableBody
            } else {
                winView
            }
            Spacer()
        }
        .navigationTitle(game.theme.name)
        .padding(.horizontal)
    }
    
    private var newGameButton: some View {
        Button {
            game.newGame()
        } label: {
            Text("New Game")
        }
    }
    
    private var header: some View {
        HStack {
            Text("Score: \(game.score)")
            Spacer()
            newGameButton
        }
        .font(.title)
        .frame(alignment: .top)
        .padding(.vertical)
    }
    
    private var cardTableBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0.0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
        .foregroundColor(Color(rgbaColor: game.theme.color))
    }
    
    private var winView: some View {
        Text("Congratulations!")
            .font(.largeTitle)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape
                        .fill()
                        .foregroundColor(.white)
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0.0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10.0
        static let lineWidth: CGFloat = 2.3
        static let fontScale: CGFloat = 0.75
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView()
//            .preferredColorScheme(.dark)
//        EmojiMemoryGameView()
//            .preferredColorScheme(.light)
//    }
//}
