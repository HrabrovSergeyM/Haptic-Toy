//
//  CatView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct CatView: View {
    
    @State private var showHearts = false
    @State private var heartIDs = [UUID]()
    @State private var counter = 1
    @State private var intensity: Double = 0
    @State var showHelp: Bool = false
    
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            
            ZStack {
                
                Image("cat")
                    .resizable()
                    .frame(width: 250, height: 400)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if !showHearts {
                                    withAnimation {
                                        showHearts = true
                                        HapticManager.startHaptics(intensityValue: Float(intensity))
                                        startSound(sound: "purring", type: "wav")
                                    }
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    showHearts = false
                                    heartIDs.removeAll()
                                    HapticManager.stopHaptics()
                                    stopSound()
                                }
                            }
                    )
                
                if showHearts {
                    ForEach(heartIDs, id: \.self) { id in
                        HeartsView(id: id)
                            .onAppear(perform: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    if !heartIDs.isEmpty {
                                        heartIDs.removeFirst()
                                    }
                                }
                            })
                    }
                }
                
             
                   
                
            } // ZStack
            .onReceive(timer) { _ in
                if showHearts {
                    heartIDs.append(UUID())
                }
            }
            .onAppear {
                        HapticManager.prepareHaptics()
                    }
            Text("Hold your finger to purr")
                .font(Font.system(size: 24, weight: .thin, design: .rounded))
                .padding(.bottom, 40)
            Slider(value: $intensity, in: 0.2...2, step: 0.2)
                .frame(width: 250)
              
            Text("Find your ideal intensity")
                .font(Font.system(size: 20, weight: .thin, design: .rounded))
                
            
        } // VStack
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showHelp = true
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                })
            }
        }
        .onAppear {
            showHelp = !UserDefaults.standard.bool(forKey: "CatView")
                }
        .sheet(isPresented: $showHelp, content: {
            HelpView(helpText: "Discover a new layer of interaction with a cat right on your screen. Simply hold your finger, and she'll start to purr, creating a soothing vibration. Use the slider to dial in the perfect intensity. Find your ideal intensity.", screenKey: "CatView", isPresented: $showHelp)
        })
    }
    
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}
