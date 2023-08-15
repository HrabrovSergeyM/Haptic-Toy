//
//  BubbleGameScreen.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleGameScreen: View {
    @State var showHelp: Bool = false
    @State var restartKey: Bool = false
    @State var isTapMode: Bool = true
    @State private var displayMode: DisplayMode = .standard
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                
                if isTapMode {
                    
                    BubbleGrid(restartKey: $restartKey, displayMode: $displayMode)
                    
                } else {
                    
                    GeometryReader { geometry in
                        BubbleGameKitView(sceneSize: geometry.size, displayMode: $displayMode, restartKey: $restartKey)
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        Button {
                            isTapMode.toggle()
                        } label: {
                            if isTapMode {
                                Image(systemName: "hand.draw")
                            } else {
                                Image(systemName: "hand.tap")
                            }
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                restartKey.toggle()
                                HapticManager.notification(type: .success)
                            }
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                        
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
                        
                        ToolbarHelpButton(showHelp: $showHelp)
                    }
                }
            }
            .onAppear {
                showHelp = !UserDefaults.standard.bool(forKey: "BubbleGameScreen")
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "helpViewBubble", screenKey: "BubbleGameScreen", isPresented: $showHelp)
            })
            
        }
    }
    
}

struct BubbleGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        BubbleGameScreen()
    }
}
