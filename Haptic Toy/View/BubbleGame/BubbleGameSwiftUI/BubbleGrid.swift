//
//  BubbleGrid.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleGrid: View {
    @Binding var restartKey: Bool
    @Binding var displayMode: DisplayMode
    
    var body: some View {
        let bubbleRows: Int
        let bubblesPerRow: Int
        
        switch displayMode {
        case .standard:
            bubbleRows = 10
            bubblesPerRow = 4
        case .extended:
            bubbleRows = 15
            bubblesPerRow = 7
        case .maximum:
            bubbleRows = 20
            bubblesPerRow = 9
        }
        
        return ZStack {
            VStack {
                ForEach(0..<bubbleRows, id: \.self) { index in
                    HStack {
                        ForEach(0..<(index % 2 == 0 ? bubblesPerRow : bubblesPerRow + 1), id: \.self) { _ in
                            Bubble(restartKey: $restartKey, displayMode: $displayMode)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

