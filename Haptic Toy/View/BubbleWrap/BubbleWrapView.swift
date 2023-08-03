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
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                HStack {
                    
                }
                BubbleView(restartKey: $restartKey)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    BubbleMenuButtonView()
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
            
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: NSLocalizedString("helpViewBubble", comment: ""), screenKey: "BubbleWrapView", isPresented: $showHelp)
            })
        }
    }
    
}

struct BubbleWrapView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleWrapView()
    }
}
