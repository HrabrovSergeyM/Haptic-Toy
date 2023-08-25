//
//  ToolbarHelpButton.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 29.07.2023.
//

import SwiftUI

struct ToolbarHelpButton: View {
    
    @Binding var showHelp: Bool
    
    var body: some View {
            Button(action: {
                HapticManager.notification(type: .success)
                showHelp = true
            }, label: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
            })
    }
}

struct ToolbarHelpButton_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarHelpButton(showHelp: .constant(true))
    }
}
