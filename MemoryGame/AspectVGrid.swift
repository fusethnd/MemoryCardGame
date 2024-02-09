//
//  SwiftUIView.swift
//  MemoryGame
//
//  Created by Thanadon Boontawee on 9/2/2567 BE.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View {
    var items: [Item]
    var aspectRatio = 1 as CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspecRatio: aspectRatio
            )
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
        
        return 1
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

#Preview {
    SwiftUIView()
}
