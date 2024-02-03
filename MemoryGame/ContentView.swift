//
//  ContentView.swift
//  MemoryGame
//
//  Created by Thanadon Boontawee on 2/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = EmojiViewModel()
//    static let emojis = ["👻","🎃","🕷️","🍭","👻","🎃","🕷️","🍭","🍭","👻"]
    var body: some View {
        VStack { // V - Colummn, H - Row
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                    ForEach(viewModel.cards) { card in
                        Cardview(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture { // tap on screen
                                viewModel.choose(card)
                            }
                    }
            }
            .foregroundColor(.purple)
            Spacer()
        }
        .padding()
    }
}

// id: \.self - create id
struct Cardview: View {
    var card: MemoryGameModel<String>.Card
//    @State var isFaceUp: Bool = true
//    var content: String

    init(_ card: MemoryGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.opacity(card.isFaceUp ? 0 : 1)
        }
    }
}
#Preview {
    ContentView()
}
