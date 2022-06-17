//
//  color.swift
//  progress
//
//  Created by Moriz Buehler on 17.06.22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let blue = Color("BlueColor")
    let gray = Color("GrayColor")
}
