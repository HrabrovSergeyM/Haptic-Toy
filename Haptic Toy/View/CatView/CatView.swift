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
    @State private var sliderHeartsIDs = [UUID]()
    @State private var counter = 1
    @State private var intensity: Double = 0
    @State var showHelp: Bool = false
    @State private var sliderWidth: CGFloat = 0
    @AppStorage("language")
    var language = LocalizationService.shared.language
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                ZStack {
                    Image("cat")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                        .frame(width: 220, height: 400)
                        .contentShape(CatShape())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    if !showHearts {
                                        withAnimation {
                                            showHearts = true
                                            HapticManager.startHaptics(intensityValue: Float(intensity))
                                            startRepeatingSound(sound: "purring", type: "wav")
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
                    
                    // MARK: - DEBUG
                    //                    CatShape()
                    //                        .fill(Color.red.opacity(0.5))
                    //                        .frame(width: 220, height: 400)
                    
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
                Text("catViewTitle".localized(language))
                    .font(Font.system(size: 22, weight: .thin, design: .rounded))
                    .padding(.bottom, 40)
                ZStack {
                    
                    Slider(value: $intensity, in: 0.2...2, step: 0.2)
                        .frame(width: 250)
                        .accentColor(.red)
                        .onChange(of: intensity) { newValue in
                            sliderHeartsIDs.append(UUID())
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if !sliderHeartsIDs.isEmpty {
                                    sliderHeartsIDs.removeFirst()
                                }
                            }
                            HapticManager.impact(style: .light)
                        }
                    ForEach(sliderHeartsIDs, id: \.self) { id in
                        SliderHeartView(id: id, startPosition: CGPoint(x: 100 + CGFloat(intensity) * 100, y: 0))
                    }
                }
                .frame(height: 60)
                .background(Color.clear)
                
                Text("catViewSlider".localized(language))
                    .font(Font.system(size: 20, weight: .thin, design: .rounded))
                
            } // VStack
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            .onAppear {
                showHelp = !UserDefaults.standard.bool(forKey: "CatView")
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "helpViewCat", screenKey: "CatView", isPresented: $showHelp)
            })
            
        }
    }
    
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}

