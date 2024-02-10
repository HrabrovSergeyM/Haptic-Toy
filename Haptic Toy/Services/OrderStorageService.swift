//
//  OrderStorageService.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 03.08.2023.
//

import Foundation

struct OrderStorageService {
    private static let orderKey = "gridItemsOrder"

    static func saveOrder(_ gridItems: [GridElementData]) {
        let ids = gridItems.map { $0.baseImageName }
        UserDefaults.standard.set(ids, forKey: orderKey)
    }

    static func loadOrder(_ gridItems: [GridElementData]) -> [GridElementData] {
        if let savedIds = UserDefaults.standard.object(forKey: orderKey) as? [String] {
            var orderedItems = [GridElementData]()
            for id in savedIds {
                if let index = gridItems.firstIndex(where: { $0.baseImageName.rawValue == id }) {
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
