//
//  HomeView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    
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
                    homeViewModel.loadData()
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
        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: spacing,
                pinnedViews: []) {
                    ForEach(homeViewModel.gridItemsData.indices, id: \.self) { index in
                        let data = homeViewModel.gridItemsData[index]
                        let destinationView = viewForDestination(data.destination)
                        
                        NavigationGrid(destination: destinationView,
                                       imageName: data.imageName,
                                       text: data.text,
                                       isAnimated: homeViewModel.isAnimated,
                                       offset: CGFloat(data.offset),
                                       delayTime: Double(data.delayTime))
                        .onDrag {
                            let fromIndex = index
                            return NSItemProvider(object: String(fromIndex) as NSString)
                        }
                        .onDrop(of: [.text], delegate: DropViewDelegate(item: homeViewModel.gridItemsData[index], list: $homeViewModel.gridItemsData, currentIndex: index))
                    }
                    
                }
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
    
    private func viewForDestination(_ destination: String) -> AnyView {
        switch destination {
        case "BubbleGameScreen":
            return AnyView(BubbleGameScreen())
        case "CatView":
            return AnyView(CatView())
        case "ButtonsView":
            return AnyView(ButtonsView())
        case "SlidersView":
            return AnyView(SlidersView())
        case "NumberPickerView":
            return AnyView(NumberPickerView())
        default:
            return AnyView(Text("Not Found"))
        }
    }
    
}
