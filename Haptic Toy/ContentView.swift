//
//  ContentView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @State private var isShowingSettings: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing: CGFloat = 40
    
    @State private var isAnimated: Bool = false
    
    @State private var gridItems: [GridElement] = [
        GridElement(id: UUID(), destination: AnyView(BubbleWrapView()), imageName: "bubbleWrapper", text: NSLocalizedString("bubbleWrapper", comment: ""), isAnimated: false, offset: -50, delayTime: 0),
        GridElement(id: UUID(), destination: AnyView(CatView()), imageName: "catNavigation", text: NSLocalizedString("purr", comment: ""), isAnimated: false, offset: 50, delayTime: 0),
        GridElement(id: UUID(), destination: AnyView(ToggleView()), imageName: "toggles", text: NSLocalizedString("buttonsAndToggles", comment: ""), isAnimated: false, offset: -50, delayTime: 4),
        GridElement(id: UUID(), destination: AnyView(SlidersView()), imageName: "slider", text: NSLocalizedString("slider", comment: ""), isAnimated: false, offset: 50, delayTime: 1),
        GridElement(id: UUID(), destination: AnyView(NumberPickerView()), imageName: "numberPicker", text: NSLocalizedString("rollerPicker", comment: ""), isAnimated: false, offset: 50, delayTime: 4)
    ]
    
    var body: some View {
        
        ZStack {
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                
                header
                VStack {
                    content
                        .zIndex(1)
                    
                } // VStack
                .onAppear {
                    withAnimation {
                        isAnimated = true
                    }
                    gridItems = OrderStorageService.loadOrder(gridItems)
                }
                .onDisappear {
                    withAnimation {
                        isAnimated = false
                    }
                }
            }
            .blur(radius: isShowingSettings ? 8.0 : 0, opaque: false)
            .animation(.default, value: isShowingSettings)
            if isShowingSettings {
                BlankView(
                    backgroundColor: isDarkMode ? .black : .gray,
                    backgroundOpacity: isDarkMode ? 0.3 : 0.5
                )
                .onTapGesture {
                    withAnimation {
                        isShowingSettings = false
                    }
                }
                
                
            }
            SettingsView(isShowingSettings: $isShowingSettings)
                .frame(width: 300, height: 300, alignment: .center)
                .accentColor(.primary)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding()
                .animation(.easeInOut, value: isShowingSettings)
                .offset(y: isShowingSettings ? 0 : UIScreen.main.bounds.height)
                .zIndex(3)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    private var header: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(Color(.systemGray6)).ignoresSafeArea()
            .frame(height: 60)
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
            .overlay(
                HStack {
                    Spacer()
                    Spacer()
                    Text("greeting_text")
                        .font(Font.system(size: 28, weight: .thin, design: .rounded))
                    Spacer()
                    Button {
                        isShowingSettings.toggle()
                        HapticManager.notification(type: .success)
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
                
            )
            .padding(.bottom, 0)
            .zIndex(2)
    }
    
    private var content: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: spacing,
                pinnedViews: []) {
                    ForEach(gridItems.indices, id: \.self) { index in
                        NavigationGrid(destination: gridItems[index].destination,
                                       imageName: gridItems[index].imageName,
                                       text: gridItems[index].text,
                                       isAnimated: isAnimated,
                                       offset: CGFloat(gridItems[index].offset),
                                       delayTime: Double(gridItems[index].delayTime))
                        .onDrag {
                            let fromIndex = index
                            return NSItemProvider(object: String(fromIndex) as NSString)
                        }
                        .onDrop(of: [.text], delegate: DropViewDelegate(item: gridItems[index], list: $gridItems, currentIndex: index))
                    }
                    
                } // LazyVGrid
                .padding(20)
        }
    }
    
}
