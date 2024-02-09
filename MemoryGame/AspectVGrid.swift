//
//  SwiftUIView.swift
//  MemoryGame
//
//  Created by Thanadon Boontawee on 9/2/2567 BE.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio = 1 as CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspecRatio: aspectRatio
            )
            LazyVGrid (columns: [GridItem(.adaptive(minimum: gridItemSize), spacing : 0)],
                // between column
                spacing : 0) { // between row
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode:  .fit)
                    }
            }
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspecRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return width
            }
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}

//#Preview {
//    SwiftUIView()
//}
