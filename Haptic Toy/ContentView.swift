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
    
    private let spacing: CGFloat = 40
    
    @State private var isAnimated: Bool = false

    var body: some View {
       
        NavigationStack {
            VStack {
                LazyVGrid(
                           columns: columns,
                           alignment: .center,
                           spacing: spacing,
                           pinnedViews: []) {
                               VStack {
                                   NavigationLink(destination: NumberPickerView()) {
                                       Image("numberPicker")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 200, height: 200)
                                       
                                   }
                                   Text("Roller Picker")
                                       .font(Font.system(size: 24, weight: .thin, design: .rounded))
                               }
                               .opacity(isAnimated ? 1 : 0)
                                          .offset(y: isAnimated ? 0 : -50)
                                          .animation(.easeOut(duration: 1.5), value: isAnimated)
                               
                               VStack {
                                   NavigationLink(destination: ToggleView()) {
                                       Image("toggles")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 200, height: 200)
                                   }
                                   Text("Buttons")
                                       .font(Font.system(size: 24, weight: .thin, design: .rounded))
                               }
                               .opacity(isAnimated ? 1 : 0)
                                          .offset(y: isAnimated ? 0 : -50)
                                          .animation(.easeOut(duration: 1.5), value: isAnimated)
                               
                               
                               VStack {
                                   NavigationLink(destination: SlidersView()) {
                                       Image("slider")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 200, height: 200)
                                   }
                                   Text("Sliders")
                                       .font(Font.system(size: 24, weight: .thin, design: .rounded))
                               }
                               .opacity(isAnimated ? 1 : 0)
                                          .offset(y: isAnimated ? 0 : 50)
                                          .animation(.easeOut(duration: 1.5), value: isAnimated)

                               
                               VStack {
                                   NavigationLink(destination: CatView()) {
                                       Image("catNavigation")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 200, height: 200)
                                   }
                                   Text("Purr")
                                       .font(Font.system(size: 24, weight: .thin, design: .rounded))
                               }
                               .opacity(isAnimated ? 1 : 0)
                                          .offset(y: isAnimated ? 0 : 50)
                                          .animation(.easeOut(duration: 1.5), value: isAnimated)
                                        
                               
                           } // LazyVGrid
                           .padding(20)
                
            } // VStack
            .onAppear {
                withAnimation {
                    isAnimated = true
                }
            }
            .onDisappear {
                withAnimation {
                    isAnimated = false
                }
            }
            
            
        } // NavigationStack
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
