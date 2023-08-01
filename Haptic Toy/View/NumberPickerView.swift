//
//  NumberPickerView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct NumberPickerView: View {
    
    @State private var selection = 300
    @State var showHelp: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            Picker("", selection: $selection) {
                ForEach(0..<600, id: \.self) {
                    Text(String(format: "%01d", $0 % 60))
                }
            } // Picker
            .pickerStyle(WheelPickerStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "Immerse yourself in a tranquil world of tactile sensations. Allow yourself to unwind simply by spinning the Wheel Picker. Delight in the subtle vibration and calming sound that envelop you. Discover a world of serenity and relaxation. Find your ideal speed.", screenKey: "NumberPickerView", isPresented: $showHelp)
            })
        }
        
    
    }
}

struct NumberPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPickerView()
    }
}
