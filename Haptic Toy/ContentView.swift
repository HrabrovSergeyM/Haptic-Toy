//
//  ContentView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//
// TODO: Description for the screen

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
            
            ZStack {
                Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
                VStack {
                    Text("Select your experience")
                        .font(Font.system(size: 28, weight: .thin, design: .rounded))
                        .padding(.top, 40)
                    Spacer()
                    
                    VStack {
                        ScrollView {
                            LazyVGrid(
                                columns: columns,
                                alignment: .center,
                                spacing: spacing,
                                pinnedViews: []) {
                                    
                                    NavigationGrid(destination: AnyView(BubbleWrapView()),
                                                   imageName: "bubbleWrapper",
                                                   text: "Bubble Wrapper",
                                                   isAnimated: isAnimated,
                                                   offset: 50,
                                                   delayTime: 3)
                                    
                                    NavigationGrid(destination: AnyView(ToggleView()),
                                                   imageName: "toggles",
                                                   text: "Buttons",
                                                   isAnimated: isAnimated,
                                                   offset: 50,
                                    delayTime: 2)
                                   
                                    
                                    NavigationGrid(destination: AnyView(SlidersView()),
                                                   imageName: "slider",
                                                   text: "Sliders",
                                                   isAnimated: isAnimated,
                                                   offset: 50,
                                                   delayTime: 2.5)
                                    NavigationGrid(destination: AnyView(CatView()),
                                                   imageName: "catNavigation",
                                                   text: "Purr",
                                                   isAnimated: isAnimated,
                                                   offset: -50,
                                                   delayTime: 2)
                                    
                                        NavigationGrid(destination: AnyView(NumberPickerView()),
                                                       imageName: "numberPicker",
                                                       text: "Roller Picker",
                                                       isAnimated: isAnimated,
                                                       offset: -50,
                                        delayTime: 1)
                                 
                                    
                                    
                                   
                                      
                                  
                                    
                                    
                                      
                                 
                                  
                                       
                                   
                                  
                                } // LazyVGrid
                                .padding(20)
                        }
                        
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
                    
                    Spacer()
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
