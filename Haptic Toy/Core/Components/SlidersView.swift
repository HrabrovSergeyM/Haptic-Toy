//
//  SlidersView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

//TODO: Picker Soft/Light/... with Menu, added haptics

import SwiftUI

struct SlidersView: View {
    
    @State var sliderValue: Double = 0
    @State var hapticStyle: HapticStyle = .soft
    @State var sliderTitle: String = "Soft"
    @State var titleWeight: Font.Weight = .thin
    @State var showHelp: Bool = false
    
    var body: some View {
        
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                Slider(value: $sliderValue, in: 0...1, step: 0.1)
                    .onChange(of: sliderValue) { newValue in
                        HapticManager.impact(style: hapticStyle.feedbackStyle)
                    }
                Text(sliderTitle)
                    .font(Font.system(size: 24, weight: titleWeight, design: .rounded))
                Spacer()
                Menu {
                    ForEach(HapticStyle.allCases, id: \.self) { style in
                        MenuButton(style: style, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
                            
                    }
                } label: {
                    Capsule()
                        .cornerRadius(0)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 75)
                        .overlay(alignment: .center, content: {
                            Text("Press and find your ideal style")
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 20, weight: .thin, design: .rounded))

                        })
                }
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 4)
                .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 80)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "Welcome to a new world of tactile sensations. With the slider, you can control the intensity of vibration, feeling pleasant waves under your fingertips. Want to diversify your feelings? Press the button below and choose one of many vibration styles from the menu. Experiment and find your ideal style.", isPresented: $showHelp)
            })
        
    }
}

struct SlidersView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersView()
    }
}
