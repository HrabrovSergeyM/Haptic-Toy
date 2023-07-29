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
                Button {
                    hapticStyle = .soft
                    withAnimation(.easeOut(duration: 0.3)) {
                        sliderTitle = "Soft"
                        titleWeight = .thin
                        sliderValue = 0
                    }
                } label: {
                    Text("Soft")
                        .font(Font.system(size: 24, weight: .thin, design: .rounded))
                }
                Button {
                    hapticStyle = .light
                    withAnimation(.easeIn(duration: 0.3)) {
                        sliderTitle = "Light"
                        titleWeight = .light
                        sliderValue = 0
                    }
                } label: {
                    Text("Light")
                        .font(Font.system(size: 24, weight: .regular, design: .rounded))
                }

                Button {
                    hapticStyle = .medium
                    withAnimation(.easeIn(duration: 0.5)) {
                        sliderTitle = "Medium"
                        titleWeight = .medium
                        sliderValue = 0
                    }
                } label: {
                    Text("Medium")
                        .font(Font.system(size: 24, weight: .regular, design: .rounded))
                }
                Button {
                    hapticStyle = .rigid
                    withAnimation(.easeIn(duration: 0.5)) {
                        sliderTitle = "Rigid"
                        titleWeight = .semibold
                        sliderValue = 0
                    }
                } label: {
                    Text("Rigid")
                        .font(Font.system(size: 24, weight: .regular, design: .rounded))
                }
                Button {
                    hapticStyle = .heavy
                    withAnimation(.easeIn(duration: 0.5)) {
                        sliderTitle = "Heavy"
                        titleWeight = .heavy
                        sliderValue = 0
                    }
                } label: {
                    Text("Heavy")
                        .font(Font.system(size: 24, weight: .regular, design: .rounded))
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

//            Text("Select your")
//            Spacer()
            
//            Slider(value: $lightSliderValue, in: 0...1, step: 0.1)
//                .onChange(of: lightSliderValue) { newValue in
//                    HapticManager.impact(style: .light)
//                }
//            Text("Light")
//                .font(Font.system(size: 24, weight: .light, design: .rounded))
//
//            Slider(value: $mediumSliderValue, in: 0...1, step: 0.1)
//                .onChange(of: mediumSliderValue) { newValue in
//                    HapticManager.impact(style: .medium)
//                }
//            Text("Medium")
//                .font(Font.system(size: 24, weight: .regular, design: .rounded))
//
//            Slider(value: $rigidSliderValue, in: 0...1, step: 0.1)
//                .onChange(of: rigidSliderValue) { newValue in
//                    HapticManager.impact(style: .rigid)
//                }
//            Text("Rigid")
//                .font(Font.system(size: 24, weight: .semibold, design: .rounded))
//
//            Slider(value: $heavySliderValue, in: 0...1, step: 0.1)
//                .onChange(of: heavySliderValue) { newValue in
//                    HapticManager.impact(style: .heavy)
//                }
//            Text("Heavy")
//                .font(Font.system(size: 24, weight: .bold, design: .rounded))
            
            
        }
        .padding(.horizontal, 80)
    }
}

struct SlidersView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersView()
    }
}
