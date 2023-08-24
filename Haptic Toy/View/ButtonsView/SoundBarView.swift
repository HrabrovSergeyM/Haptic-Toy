//
//  SoundBarView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import SwiftUI

struct SoundBarView: View {
    @Binding var isShowingSoundBar: Bool
    @Binding var selectedSound: [String]
    let feverNightsSound: [String] = ["feverNights0", "feverNights1", "feverNights2", "feverNights3", "feverNights4", "feverNights5", "feverNights6", "feverNights7", "feverNights8", "feverNights9", "feverNights10", "feverNights11", "feverNights12", "feverNights13", "feverNights14"]
    let breakingBassSound: [String] = ["breakingBass0", "breakingBass1", "breakingBass2", "breakingBass3", "breakingBass4", "breakingBass5", "breakingBass6", "breakingBass7", "breakingBass8", "breakingBass9", "breakingBass10", "breakingBass11", "breakingBass12", "breakingBass13", "breakingBass14"]
    let sounds: [[String]] = []
    var language = LocalizationService.shared.language
    
    var body: some View {
        ZStack {
            
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                
                Button {
                    selectedSound = feverNightsSound
                    isShowingSoundBar = false
                } label: {
                    HStack{
                        Image(systemName: "music.note")
                        Text("Fever Nights")
                    }
                    .foregroundColor(selectedSound == feverNightsSound ? .primary : .gray)
                    
                }
                Button {
                    selectedSound = breakingBassSound
                    isShowingSoundBar = false
                } label: {
                    HStack{
                        Image(systemName: "music.note")
                        Text("Breaking Bass")
                    }
                    .foregroundColor(selectedSound == breakingBassSound ? .primary : .gray)
                }
                
            }
        }
    }
    
}

struct SoundBarView_Previews: PreviewProvider {
    static var previews: some View {
        SoundBarView(isShowingSoundBar: .constant(true), selectedSound: .constant(["sound"]))
    }
}
