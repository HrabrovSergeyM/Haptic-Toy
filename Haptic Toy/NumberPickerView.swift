//
//  NumberPickerView.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.07.2023.
//

import SwiftUI

struct NumberPickerView: View {
    
    @State private var selection = 300
    @State var showHelp: Bool = false
    @ObservedObject var theme = ColorThemeChangerService.shared
    var themes: [ColorTheme] = themeData
    let value: String
    init(value: String) {
        self.value = value
        print("init: \(value)")
    }
    
    var body: some View {
        
        ZStack {
            
            themes[self.theme.themeSettings].themeSecondaryColor.ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: UIScreen.main.bounds.size.width - 18, height: 32)
                    .foregroundColor(themes[self.theme.themeSettings].id != 0 ? themes[self.theme.themeSettings].themeAccentColor : .gray.opacity(0.1))
                Picker("", selection: $selection) {
                    ForEach(0..<600, id: \.self) {
                        Text(String(format: "%01d", $0 % 60))
                            .frame(width: 150)
                            .foregroundColor(themes[self.theme.themeSettings].themeForegroundColor)
                           
                            
                    }
                } // Picker
            }
            .pickerStyle(WheelPickerStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarHelpButton(showHelp: $showHelp)
                }
            }
            .onAppear {
                showHelp = !UserDefaults.standard.bool(forKey: "NumberPickerView")
            }
            .sheet(isPresented: $showHelp, content: {
                HelpView(helpText: "helpViewPicker", screenKey: "NumberPickerView", isPresented: $showHelp)
            })
        }
        
        
    }
}

struct NumberPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPickerView(value: "NumberPickerView")
    }
}
