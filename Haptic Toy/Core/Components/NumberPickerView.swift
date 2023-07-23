//
//  NumberPickerView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct NumberPickerView: View {
    
    @State private var selection = 300
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(0..<600, id: \.self) {
                Text(String(format: "%01d", $0 % 60))
            }
        } // Picker
        .pickerStyle(WheelPickerStyle())
    }
}

struct NumberPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPickerView()
    }
}
