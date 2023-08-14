//
//  CatView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct CatView: View {
    @StateObject  var catViewModel: CatViewModel = CatViewModel()
    @AppStorage("language")
    var language = LocalizationService.shared.language
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                ZStack {
                    
                    catImage
                    
                    if catViewModel.showHearts {
                        flyingHearts
                    }
                } // ZStack
                .onReceive(timer) { _ in
                    if catViewModel.showHearts {
                        catViewModel.heartIDs.append(UUID())
                    }
                }
                Text("catViewTitle".localized(language))
                    .font(Font.system(size: 22, weight: .thin, design: .rounded))
                    .padding(.bottom, 40)
                
                intensitySlider
                
                Text("catViewSlider".localized(language))
                    .font(Font.system(size: 20, weight: .thin, design: .rounded))
                
            } // VStack
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $catViewModel.showHelp)
                }
            }
            .onAppear {
                catViewModel.viewAppeared()
            }
            .sheet(isPresented: $catViewModel.showHelp, content: {
                HelpView(helpText: "helpViewCat", screenKey: "CatView", isPresented: $catViewModel.showHelp)
            })
            
        }
    }
    
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}

extension CatView {
    
    private var catImage: some View {
        
        Image("cat")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.primary)
            .frame(width: 220, height: 400)
            .contentShape(CatShape())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !catViewModel.showHearts {
                            withAnimation {
                                catViewModel.startGesture()
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            catViewModel.endGesture()
                        }
                    }
            )
        
    }
    
    private var flyingHearts: some View {
        ForEach(catViewModel.heartIDs, id: \.self) { id in
            HeartsView(id: id)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if !catViewModel.heartIDs.isEmpty {
                            catViewModel.heartIDs.removeFirst()
                        }
                    }
                })
        }
    }
    
    private var intensitySlider: some View {
        ZStack {
            
            Slider(value: $catViewModel.intensity, in: 0.2...2, step: 0.2)
                .frame(width: 250)
                .accentColor(.red)
                .onChange(of: catViewModel.intensity) { newValue in
                    catViewModel.onChangeSlider()
                }
            ForEach(catViewModel.sliderHeartsIDs, id: \.self) { id in
                SliderHeartView(id: id, startPosition: CGPoint(x: 100 + CGFloat(catViewModel.intensity) * 100, y: 0))
            }
        }
        .frame(height: 60)
        .background(Color.clear)
    }
    
}
