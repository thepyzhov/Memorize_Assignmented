//
//  Color+RGBAColor.swift
//  Memorize_Assignmented
//
//  Created by Dmitry Pyzhov on 14.02.2022.
//

import SwiftUI

extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}
