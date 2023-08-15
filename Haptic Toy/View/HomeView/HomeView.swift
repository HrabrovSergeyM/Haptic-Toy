//
//  HomeView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @StateObject  var homeViewModel: HomeViewModel = HomeViewModel()
//    @State private var isShowingSettings: Bool = false
//
//    @State private var isAnimated: Bool = false
    
    @State private var gridItems: [GridElement] = [
        GridElement(id: UUID(), destination: AnyView(BubbleWrapView()), imageName: "bubbleWrapper", text: "bubbleWrapper", isAnimated: false, offset: -50, delayTime: 0),
        GridElement(id: UUID(), destination: AnyView(CatView()), imageName: "catNavigation", text: "purr", isAnimated: false, offset: 50, delayTime: 0),
        GridElement(id: UUID(), destination: AnyView(ButtonsView()), imageName: "toggles", text: "buttonsAndToggles", isAnimated: false, offset: -50, delayTime: 4),
        GridElement(id: UUID(), destination: AnyView(SlidersView()), imageName: "slider", text: "slider", isAnimated: false, offset: 50, delayTime: 1),
        GridElement(id: UUID(), destination: AnyView(NumberPickerView()), imageName: "numberPicker", text: "rollerPicker", isAnimated: false, offset: 50, delayTime: 4)
    ]
    
    private var language = LocalizationService.shared.language
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing: CGFloat = 40
    
    var body: some View {
        
        ZStack {
            Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
            
            VStack {
                HomeHeader(isShowingSettings: $homeViewModel.isShowingSettings)
                VStack {
                    content
                        .zIndex(1)
                    
                } // VStack
                .onAppear {
                    withAnimation {
                        homeViewModel.isAnimated = true
                    }
                    gridItems = OrderStorageService.loadOrder(gridItems)
                }
                .onDisappear {
                    withAnimation {
                        homeViewModel.isAnimated = false
                    }
                }
            }
            .blur(radius: homeViewModel.isShowingSettings ? 8.0 : 0, opaque: false)
            .animation(.default, value: homeViewModel.isShowingSettings)
            if homeViewModel.isShowingSettings {
                blankView
            }
            settingsView
            
        }
        .navigationTitle("")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
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
                                       isAnimated: homeViewModel.isAnimated,
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
    
    private var settingsView: some View {
        SettingsView(isShowingSettings: $homeViewModel.isShowingSettings)
            .frame(width: 300, height: 300, alignment: .center)
            .accentColor(.primary)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
            .animation(.easeInOut, value: homeViewModel.isShowingSettings)
            .offset(y: homeViewModel.isShowingSettings ? 0 : UIScreen.main.bounds.height)
            .zIndex(3)
    }
    
    private var blankView: some View {
        BlankView(
            backgroundColor: isDarkMode ? .black : .gray,
            backgroundOpacity: isDarkMode ? 0.3 : 0.5
        )
        .onTapGesture {
            withAnimation {
                homeViewModel.isShowingSettings = false
            }
        }
    }
    
}
