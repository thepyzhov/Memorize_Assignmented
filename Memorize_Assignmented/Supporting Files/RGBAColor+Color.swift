//
//  RGBAColor+Color.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 14.02.2022.
//

import SwiftUI

extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0.5
        var green: CGFloat = 0.5
        var blue: CGFloat = 0.5
        var alpha: CGFloat = 1.0
        if let cgColor = color.cgColor {
            UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}
