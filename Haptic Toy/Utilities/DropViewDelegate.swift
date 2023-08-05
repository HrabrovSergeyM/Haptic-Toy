//
//  DropViewDelegate.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 03.08.2023.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    let item: GridElement
    @Binding var list: [GridElement]
    var currentIndex: Int
    
    func performDrop(info: DropInfo) -> Bool {
        if let itemData = info.itemProviders(for: [.text]).first {
            itemData.loadObject(ofClass: NSString.self) { (data, _) in
                if let fromIndex = Int(data as! String) {
                    DispatchQueue.main.async {
                        let fromPage = list[fromIndex]
                        list[fromIndex] = list[currentIndex]
                        list[currentIndex] = fromPage
                        OrderStorageService.saveOrder(list)
                    }
                }
            }
        }
        return true
    }
}
