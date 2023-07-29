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
    @State var hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle = .soft
    @State var sliderTitle: String = "Soft"
    @State var titleWeight: Font.Weight = .thin
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Spacer()
            Slider(value: $sliderValue, in: 0...1, step: 0.1)
                .onChange(of: sliderValue) { newValue in
                    HapticManager.impact(style: hapticStyle)
                }
            Text(sliderTitle)
                .font(Font.system(size: 24, weight: titleWeight, design: .rounded))
            Spacer()
            Menu {
                MenuButton(title: "Soft", weight: .thin, style: .soft, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
                   MenuButton(title: "Light", weight: .light, style: .light, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
                   MenuButton(title: "Medium", weight: .medium, style: .medium, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
                   MenuButton(title: "Rigid", weight: .semibold, style: .rigid, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
                   MenuButton(title: "Heavy", weight: .heavy, style: .heavy, hapticStyle: $hapticStyle, sliderTitle: $sliderTitle, titleWeight: $titleWeight, sliderValue: $sliderValue)
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
    }
}

struct SlidersView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersView()
    }
}
