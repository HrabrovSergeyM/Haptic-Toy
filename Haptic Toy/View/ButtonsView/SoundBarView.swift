//
//  SoundBarView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import SwiftUI

struct SoundBarView: View {
    @ObservedObject var buttonsModelView: ButtonsModelView = ButtonsModelView()
    @Binding var isShowingSoundBar: Bool
    @Binding var selectedSound: [String]
    var language = LocalizationService.shared.language
    
    var body: some View {
        ZStack {
            
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(buttonsModelView.sounds, id: \.name) { sound in
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