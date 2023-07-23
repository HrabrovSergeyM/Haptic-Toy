//
//  ContentView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

import CoreHaptics


struct ContentView: View {

    
    private let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    private let spacing: CGFloat = 20
    
    @State private var segmentedPickerValue = "1"
    private var segmentedPickerValues = ["0", "1", "2"]
    
    
    @State private var buttonToggle = false
    @State private var switchToggle = false
    
    @State private var sliderValue: Double = 0
    @State private var sliderValue1: Double = 0
    @State private var sliderValue2: Double = 0
    @State private var sliderValue3: Double = 0
    
    @State private var selection = 300
    var minutes: Int {selection % 60}
    
    var body: some View {
       
        VStack {
            
            LazyVGrid(
                       columns: columns,
                       alignment: .center,
                       spacing: spacing,
                       pinnedViews: []) {
                           Picker("", selection: $selection) {
                               ForEach(0..<600, id: \.self) {
                                   Text(String(format: "%01d", $0 % 60))
                               }
                           } // Picker
                           .pickerStyle(WheelPickerStyle())
                           
                           VStack(spacing: 40) {
                               Toggle("Toggle", isOn: $buttonToggle)
                                   .toggleStyle(CheckboxStyle())
                               
                               Toggle("Toggle", isOn: $switchToggle)
                                   .toggleStyle(.switch)
                                   .labelsHidden()
 
                           } // VStack
                           
                           Slider(value: $sliderValue, in: 0...0.1)
                               .onChange(of: sliderValue) { newValue in
                                   HapticManager.impact(style: .soft)
                               }
                           Slider(value: $sliderValue1, in: 0...0.1)
                               .onChange(of: sliderValue1) { newValue in
                                   HapticManager.impact(style: .light)
                               }
                           Slider(value: $sliderValue2, in: 0...0.1)
                               .onChange(of: sliderValue2) { newValue in
                                   HapticManager.impact(style: .medium)
                               }
                           Slider(value: $sliderValue3, in: 0...0.1)
                               .onChange(of: sliderValue3) { newValue in
                                   HapticManager.impact(style: .rigid)
                               }
                           
                           Picker("", selection: $segmentedPickerValue) {
                               ForEach(segmentedPickerValues, id: \.self) {
                                   Text($0)
                               }
                           } // Picker
                           .onChange(of: segmentedPickerValue, perform: { newValue in
                               HapticManager.notification(type: .warning)
                           })
                           .pickerStyle(.segmented)
                           
                           
//                           Text("Hello")
//                           Text("Hello")
//                           Text("Hello")
                           
                       } // LazyVGrid
                       .padding(20)
            
        } // VStack
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
