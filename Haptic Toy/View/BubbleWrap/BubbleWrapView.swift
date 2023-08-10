//
//  BubbleWrapView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleWrapView: View {
    @State var showHelp: Bool = false
    @State var restartKey: Bool = false
    @State var gameMode: Bool = true
    //    @State var split: Bool = false
    @State private var displayMode: DisplayMode = .standard
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            VStack {
                if gameMode {
                    
                    BubbleView(restartKey: $restartKey, displayMode: $displayMode)
                    
                } else {
                    GeometryReader { geometry in
                        SpriteKitView(sceneSize: geometry.size, displayMode: $displayMode, restartKey: $restartKey)
                    }
                }
                
                
            }
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        gameMode.toggle()
                    } label: {
                        if gameMode {
                            Image(systemName: "hand.tap")
                        } else {
                            Image(systemName: "hand.draw")
                        }
                    }

                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            restartKey.toggle()
                            HapticManager.notification(type: .success)
                        }
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            displayMode.toggle()
                        }
                        switch displayMode {
                        case .standard:
                            HapticManager.impact(style: .light)
                        case .extended:
                            HapticManager.impact(style: .medium)
                        case .maximum:
                            HapticManager.impact(style: .heavy)
                        }
                        
                    } label: {
                        switch displayMode {
                        case .standard:
                            Image(systemName: "rectangle.split.2x2.fill")
                        case .extended:
                            Image(systemName: "rectangle.split.3x3.fill")
                        case .maximum:
                            Image(systemName: "square.split.2x1.fill")
                        }
                    }
                    
                }
            }
            .onAppear {
                showHelp = !UserDefaults.standard.bool(forKey: "BubbleWrapView")
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "helpViewBubble", screenKey: "BubbleWrapView", isPresented: $showHelp)
            })
            
        }
    }
    
}

struct BubbleWrapView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleWrapView()
    }
}
