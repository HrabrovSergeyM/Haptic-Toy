//
//  SlidersView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct SlidersView: View {
    
    @State var softSliderValue: Double = 0
    @State var lightSliderValue: Double = 0
    @State var mediumSliderValue: Double = 0
    @State var rigidSliderValue: Double = 0
    @State var heavySliderValue: Double = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Slider(value: $softSliderValue, in: 0...0.1)
                .onChange(of: softSliderValue) { newValue in
                    HapticManager.impact(style: .soft)
                }
            Text("Soft")
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
            
            Slider(value: $lightSliderValue, in: 0...0.1)
                .onChange(of: lightSliderValue) { newValue in
                    HapticManager.impact(style: .light)
                }
            Text("Light")
                .font(Font.system(size: 24, weight: .light, design: .rounded))
            
            Slider(value: $mediumSliderValue, in: 0...0.1)
                .onChange(of: mediumSliderValue) { newValue in
                    HapticManager.impact(style: .medium)
                }
            Text("Medium")
                .font(Font.system(size: 24, weight: .regular, design: .rounded))
            
            Slider(value: $rigidSliderValue, in: 0...0.1)
                .onChange(of: rigidSliderValue) { newValue in
                    HapticManager.impact(style: .rigid)
                }
            Text("Rigid")
                .font(Font.system(size: 24, weight: .semibold, design: .rounded))
            
            Slider(value: $heavySliderValue, in: 0...0.1)
                .onChange(of: heavySliderValue) { newValue in
                    HapticManager.impact(style: .heavy)
                }
            Text("Heavy")
                .font(Font.system(size: 24, weight: .bold, design: .rounded))
            
            
        }
        .padding(.horizontal, 100)
    }
}

struct SlidersView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersView()
    }
}
