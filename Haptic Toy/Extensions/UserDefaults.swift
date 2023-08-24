//
//  UserDefaults.swift
//  Haptic Toy
//
//  Created by Sergey Hrabrov on 24.08.2023.
//

import Foundation
import SwiftUI

extension UserDefaults {
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                colorData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData
            } catch {
                print("Failed to archive color data.")
            }
        }
        set(colorData, forKey: key)
    }

    func colorForKey(key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch {
            print("Failed to unarchive color data.")
            return nil
        }
    }
}
