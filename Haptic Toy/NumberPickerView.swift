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
            .onAppear {
                showHelp = !UserDefaults.standard.bool(forKey: "NumberPickerView")
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "helpViewPicker", screenKey: "NumberPickerView", isPresented: $showHelp)
            })
        }
        
        
    }
}

struct NumberPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPickerView()
    }
}
