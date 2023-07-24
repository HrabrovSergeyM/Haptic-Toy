//
//  CatView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct CatView: View {
    
    @State private var showHearts = false
    @State private var heartIDs = [Int]()
    @State private var counter = 1
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Image("cat")
                .resizable()
                .scaledToFit()
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onChanged { _ in
                            withAnimation {
                                showHearts = true
//                                heartIDs.append(UUID())
                            }
                        }
                        .onEnded { _ in
                            withAnimation {
                                showHearts = false
                            }
                        }
                )
            
            if showHearts {
                ForEach(heartIDs, id: \.self) { id in
                    HeartsView(id: id)
                        .onAppear(perform: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                heartIDs.removeFirst()
                            }
                        })
                }
            }
               
            
        } // ZStack
        .onReceive(timer) { _ in
            if showHearts {
                heartIDs.append(counter)
                counter += 1
            }
        }
    }
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}
