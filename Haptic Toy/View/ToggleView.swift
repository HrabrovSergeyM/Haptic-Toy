//
//  ToggleView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct ToggleView: View {
    
    @State private var buttonToggle = false
    @State private var switchToggle = false
    @State var showHelp: Bool = false
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack(spacing: 40) {
                Toggle("Toggle", isOn: $buttonToggle)
                    .toggleStyle(CheckboxStyle())
                
                Toggle("Toggle", isOn: $switchToggle)
                    .toggleStyle(.switch)
                    .labelsHidden()

            } // VStack
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "Dive into an ocean of tactile responses. Each button and toggle possesses its unique sound and vibration, offering you a new level of interactivity. Let your sensations travel across this diversity of responses. Explore a new world of tactility. Find your ideal toggle. Find your ideal button.", screenKey: "ToggleView", isPresented: $showHelp)
        })
        }
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
