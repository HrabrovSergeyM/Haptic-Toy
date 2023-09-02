//
//  HomeViewModel.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 15.08.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var isShowingSettings: Bool = false
    @Published var isAnimated: Bool = false
    @Published var gridItemsData: [GridElementData] = [
        GridElementData(id: UUID(), destination: "BubbleGameScreen", baseImageName: "bubbleWrapper", text: "bubbleWrapper", offset: -50, delayTime: 0),
        GridElementData(id: UUID(), destination: "CatView", baseImageName: "catNavigation", text: "purr", offset: 50, delayTime: 0),
        GridElementData(id: UUID(), destination: "ButtonsView", baseImageName: "toggles", text: "buttonsAndToggles", offset: -50, delayTime: 4),
        GridElementData(id: UUID(), destination: "SlidersView", baseImageName: "slider", text: "slider", offset: 50, delayTime: 1),
        GridElementData(id: UUID(), destination: "NumberPickerView", baseImageName: "numberPicker", text: "rollerPicker", offset: 50, delayTime: 4)
    ]

    func loadData() {
        gridItemsData = OrderStorageService.loadOrder(gridItemsData)
    }

    func imageNameForCurrentTheme(baseImageName: String) -> String {
        let themeName = themeData[ColorThemeChangerService.shared.themeSettings].themeName
        return "\(baseImageName)\(themeName)"
    }
}
