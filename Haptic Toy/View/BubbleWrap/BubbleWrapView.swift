//
//  BubbleWrapView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 30.07.2023.
//

import SwiftUI

struct BubbleWrapView: View {
    @State var showHelp: Bool = false
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                HStack {
                    
                }
                BubbleView()
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
