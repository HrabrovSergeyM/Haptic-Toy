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
    @State var showHelp: Bool = false
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    
    private var language = LocalizationService.shared.language
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing: CGFloat = 40
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                themes[self.theme.themeSettings].themeSecondaryColor.ignoresSafeArea()
                
                VStack {
                    HomeHeader(isShowingSettings: $homeViewModel.isShowingSettings)
                    content
                        .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                        .navigationTitle("")
                        .navigationDestination(for: String.self) { value in
                            switch value {
                            case GridDestination.bubbleGameScreen.rawValue:
                                BubbleGameScreen(value: "BubbleGameView")
                            case GridDestination.catView.rawValue:
                                CatView(value: "CatView")
                            case GridDestination.buttonsView.rawValue:
                                ButtonsView(value: "ButtonsView")
                            case GridDestination.slidersView.rawValue:
                                SlidersView(value: "SlidersView")
                            case GridDestination.numberPickerView.rawValue:
                                NumberPickerView(value: "NumberPickerView")
                            default:
                                (Text("Not Found"))
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                showHelp = !UserDefaults.standard.bool(forKey: "HomeView")
                            }
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
            //            .statusBarHidden(true)
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "helpViewHome", screenKey: "HomeView", isPresented: $showHelp)
            })
            
        }
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
                        let currentImageName = homeViewModel.imageNameForCurrentTheme(baseImageName: data.baseImageName.rawValue)
                        
                        NavigationGrid(destination: data.destination.rawValue,
                                       imageName: currentImageName,
                                       text: data.text.rawValue,
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
        .background(ThemeChangerController(isDarkMode: $isDarkMode))
    }
    
    private var settingsView: some View {
        SettingsView(isShowingSettings: $homeViewModel.isShowingSettings)
            .frame(width: 300, height: 400, alignment: .center)
            .accentColor(.primary)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
            .animation(.easeInOut, value: homeViewModel.isShowingSettings)
            .offset(y: homeViewModel.isShowingSettings ? 0 : UIScreen.main.bounds.height)
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

