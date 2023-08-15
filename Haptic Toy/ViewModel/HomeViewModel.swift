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
    
    
    func loadData() {
        
    }
    
}
