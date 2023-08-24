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
    var language = LocalizationService.shared.language
    let sounds: [Sound] = [
        Sound(name: "Breaking Bass", tracks: ["breakingBass0", "breakingBass1", "breakingBass2", "breakingBass3", "breakingBass4", "breakingBass5", "breakingBass6", "breakingBass7", "breakingBass8", "breakingBass9", "breakingBass10", "breakingBass11", "breakingBass12", "breakingBass13", "breakingBass14"]),
        Sound(name: "Fever Nights", tracks: ["feverNights0", "feverNights1", "feverNights2", "feverNights3", "feverNights4", "feverNights5", "feverNights6", "feverNights7", "feverNights8", "feverNights9", "feverNights10", "feverNights11", "feverNights12", "feverNights13", "feverNights14"]),
        Sound(name: "Acoustic Guitar", tracks: ["acousticGuitar0", "acousticGuitar1", "acousticGuitar2", "acousticGuitar3", "acousticGuitar4", "acousticGuitar5", "acousticGuitar6", "acousticGuitar7", "acousticGuitar8", "acousticGuitar9", "acousticGuitar10", "acousticGuitar11", "acousticGuitar12", "acousticGuitar13", "acousticGuitar14"])
    ]
    
    var body: some View {
        ZStack {
            
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(sounds, id: \.name) { sound in
                    Button {
                        withAnimation {
                            selectedSound = sound.tracks
                            isShowingSoundBar = false
                        }
                    } label: {
                        HStack{
                            Image(systemName: "music.note")
                            Text(sound.name)
                        }
                        .foregroundColor(selectedSound == sound.tracks ? .primary : .gray)
                        .font(selectedSound == sound.tracks ? .title : .title2)
                    }
                }
            }
        }
    }
    
}

struct SoundBarView_Previews: PreviewProvider {
    static var previews: some View {
        SoundBarView(isShowingSoundBar: .constant(true), selectedSound: .constant(["feverNights0", "feverNights1", "feverNights2", "feverNights3", "feverNights4", "feverNights5", "feverNights6", "feverNights7", "feverNights8", "feverNights9", "feverNights10", "feverNights11", "feverNights12", "feverNights13", "feverNights14"]))
    }
}
