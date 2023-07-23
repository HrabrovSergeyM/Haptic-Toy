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
    
    var body: some View {
        VStack(spacing: 40) {
            Toggle("Toggle", isOn: $buttonToggle)
                .toggleStyle(CheckboxStyle())
            
            Toggle("Toggle", isOn: $switchToggle)
                .toggleStyle(.switch)
                .labelsHidden()

        } // VStack
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
