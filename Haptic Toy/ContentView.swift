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
            
            ZStack {
                Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
                VStack {
                    Text("greeting_text")
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
                                                   text: NSLocalizedString("bubbleWrapper", comment: ""),
                                                   isAnimated: isAnimated,
                                                   offset: -50,
                                                   delayTime: 0)
                                    
                                    NavigationGrid(destination: AnyView(ToggleView()),
                                                   imageName: "toggles",
                                                   text: NSLocalizedString("buttonsAndToggles", comment: ""),
                                                   isAnimated: isAnimated,
                                                   offset: -50,
                                                   delayTime: 4)
                                   
                                    
                                    NavigationGrid(destination: AnyView(SlidersView()),
                                                   imageName: "slider",
                                                   text: NSLocalizedString("slider", comment: ""),
                                                   isAnimated: isAnimated,
                                                   offset: 50,
                                                   delayTime: 1)
                                    
                                    NavigationGrid(destination: AnyView(CatView()),
                                                   imageName: "catNavigation",
                                                   text: NSLocalizedString("purr", comment: ""),
                                                   isAnimated: isAnimated,
                                                   offset: 50,
                                                   delayTime: 0)
                                    
                                        NavigationGrid(destination: AnyView(NumberPickerView()),
                                                       imageName: "numberPicker",
                                                       text: NSLocalizedString("rollerPicker", comment: ""),
                                                       isAnimated: isAnimated,
                                                       offset: 50,
                                                       delayTime: 4)
                                 
                                    
                                    
                                   
                                      
                                  
                                    
                                    
                                      
                                 
                                  
                                       
                                   
                                  
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
