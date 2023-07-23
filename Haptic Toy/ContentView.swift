//
//  ContentView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    private let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    private let spacing: CGFloat = 20

    var body: some View {
       
        NavigationStack {
            VStack {
                LazyVGrid(
                           columns: columns,
                           alignment: .center,
                           spacing: spacing,
                           pinnedViews: []) {
                               NavigationLink(destination: NumberPickerView()) {
                                   Image("numberPicker")
                                       .resizable()
                                       .scaledToFit()
                               }
                               NavigationLink(destination: ToggleView()) {
                                   Image("toggles")
                                       .resizable()
                                       .scaledToFit()
                               }
                               
                               NavigationLink(destination: SlidersView()) {
                                   Image("slider")
                                       .resizable()
                                       .scaledToFit()
                               }
                               
                               NavigationLink(destination: SegmentedPicker()) {
                                   Image("segmentedPicker")
                                       .resizable()
                                       .scaledToFit()
                               }
                               
                           } // LazyVGrid
                           .padding(20)
                
            } // VStack
            
        } // NavigationStack
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
