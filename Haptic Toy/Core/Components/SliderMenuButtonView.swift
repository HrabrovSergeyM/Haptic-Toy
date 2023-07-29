//
//  SliderMenuButtonView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 29.07.2023.
//

import SwiftUI

struct MenuButton: View {
    
    var title: String
    var weight: Font.Weight
    var style: UIImpactFeedbackGenerator.FeedbackStyle
    
    @Binding var hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle
    @Binding var sliderTitle: String
    @Binding var titleWeight: Font.Weight
    @Binding var sliderValue: Double

    var body: some View {
        Button {
            hapticStyle = style
            withAnimation(.easeIn(duration: 0.5)) {
                sliderTitle = title
                titleWeight = weight
                sliderValue = 0
            }
        } label: {
            Text(title)
        }
    }
}
