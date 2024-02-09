//
//  ContentView.swift
//  MemoryGame
//
//  Created by Thanadon Boontawee on 2/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = EmojiViewModel()
    
    let spacing = 4 as CGFloat
    let aspectRatio = 2/3 as CGFloat
    
    var body: some View {
        VStack { // V - Colummn, H - Row
            AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
                Cardview(card)
                    .padding(spacing)
                    .onTapGesture { // tap on screen
                        viewModel.choose(card)
                    }
                    .animation(.default, value: viewModel.cards)
            }
            .foregroundColor(.purple)
            Spacer()
            Button("Shuffle") {
                withAnimation {
                    viewModel.shuffle()
                }
            }
            
            // LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()])
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
//                // for support landscape
//                    ForEach(viewModel.cards) { card in
//                        Cardview(card)
//                            .aspectRatio(2/3, contentMode: .fit)
//                            .onTapGesture { // tap on screen
//                                viewModel.choose(card)
//                        }
//                    }
//            }
//            .foregroundColor(.purple)
//            Spacer()
        }
        .padding()
    }
}

// id: \.self - create id
struct Cardview: View, Animatable {
    var card: MemoryGameModel<String>.Card
//    @State var isFaceUp: Bool = true
//    var content: String

    init(_ card: MemoryGameModel<String>.Card) {
        self.card = card
 //       rotation = 0
    }
    
//    var rotation: Double
//    
//    var animatableData: Double {
//        get { return rotation }
//        set { rotation = newValue }
//    }
    
    var body: some View {
        // ----- ChatGPT Code -----
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.purple, lineWidth: 2)
                    )
                    .opacity(card.isFaceUp ? 1 : 0)
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.purple)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.purple, lineWidth: 2)
                    )
                    .opacity(card.isFaceUp ? 0 : 1)
                
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .rotation3DEffect(.degrees(card.isMatched ? 180 : 0), axis: (0, 1, 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .opacity(card.isFaceUp ? 1 : 0)
            }
            .opacity(!card.isFaceUp && card.isMatched ? 0 : 1)
            .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180), axis: (0, 1, 0))
            .animation(.default, value: card)

            // ----- Instructor Code -----
//        ZStack {
//            var base = RoundedRectangle(cornerRadius: 12)
//            
//            Group {
//                base.foregroundColor(Color.white)
//                base.strokeBorder(lineWidth: 2)
//                Text(card.content)
//                    .font(.system(size: 200))
//                    .minimumScaleFactor(0.01)
//                    .aspectRatio(1, contentMode: .fit)
//                    .rotation3DEffect(.degrees(card.isMatched ? 0 : 180), axis: (0,0,1)
//                    )
//                    .animation(.lenear(duration:1).repeatForever(autoreverses:false), value: card.isMatched)
//            }
//            .opacity(card.isFaceUp ? 1 : 0)
//            
//            base.opacity(card.isFaceUp ? 0 : 1)
//        }
//        .opacity(!card.isFaceUp && card.isMatched ? 0: 1)
//        .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180), axis: (0,1,0))
//        .animation(.default, value: card)
//        // .animation(.default, value: card.isFaceUp) // Fade out slowly
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
