//
//  SliderMenuButtonView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 29.07.2023.
//

import SwiftUI

struct MenuButton: View {
    var style: HapticStyle
    @Binding var hapticStyle: HapticStyle
    @Binding var sliderTitle: String
    @Binding var titleWeight: Font.Weight
    @Binding var sliderValue: Double

    var body: some View {
        Button {
            hapticStyle = style
            withAnimation(.easeIn(duration: 0.2)) {
                sliderTitle = style.rawValue.capitalized
                titleWeight = style.titleWeight
                sliderValue = 0
            }
            HapticManager.notification(type: .success)
        } label: {
            Text(style.rawValue.capitalized)
                .font(Font.system(size: 24, weight: style.titleWeight, design: .rounded))
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(style: .heavy, hapticStyle: .constant(.heavy), sliderTitle: .constant("Test"), titleWeight: .constant(.black), sliderValue: .constant(0))
    }
}
