//
//  SegmentedPicker.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct SegmentedPicker: View {
    
    @State private var segmentedPickerValue = "1"
    private var segmentedPickerValues = ["0", "1", "2"]
    
    var body: some View {
        HStack {
            Picker("", selection: $segmentedPickerValue) {
                ForEach(segmentedPickerValues, id: \.self) {
                    Text($0)
                }
            } // Picker
            .onChange(of: segmentedPickerValue, perform: { newValue in
                HapticManager.notification(type: .warning)
            })
            .pickerStyle(.segmented)
        }
        .padding(.horizontal, 100)
    }
    
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker()
            
    }
}
