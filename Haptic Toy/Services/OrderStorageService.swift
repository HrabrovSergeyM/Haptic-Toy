//
//  OrderStorageService.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 03.08.2023.
//

import Foundation

struct OrderStorageService {
    static func saveOrder(_ gridItems: [GridElement]) {
        let ids = gridItems.map { $0.imageName }
        UserDefaults.standard.set(ids, forKey: "gridItemsOrder")
    }

    static func loadOrder(_ gridItems: [GridElement]) -> [GridElement] {
        if let savedIds = UserDefaults.standard.object(forKey: "gridItemsOrder") as? [String] {
            var orderedItems = [GridElement]()
            for id in savedIds {
                if let index = gridItems.firstIndex(where: { $0.imageName == id }) {
                    orderedItems.append(gridItems[index])
                }
            }
            if orderedItems.count == gridItems.count {
                return orderedItems
            }
        }
        return gridItems
    }
}
