//
//  ContentView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
    
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
        
        NavigationStack {
            
            ZStack {
                Color(UIColor.tertiarySystemBackground).ignoresSafeArea()
                VStack {
                    Text("greeting_text")
                        .font(Font.system(size: 28, weight: .thin, design: .rounded))
                        .padding(.top, 40)
                    Spacer()
                    
                    VStack {
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
                        
                    } // VStack
                    .onAppear {
                        withAnimation {
                            isAnimated = true
                        }
                    }
                    .onDisappear {
                        withAnimation {
                            isAnimated = false
                        }
                       
                    }
                    
                    Spacer()
                }
                
            }
            
        } // NavigationStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
                    }
                }
            }
        }
        return true
    }
}
