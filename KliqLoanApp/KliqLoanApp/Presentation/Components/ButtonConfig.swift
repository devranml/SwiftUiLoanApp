//
//  ButtonConfig.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct ButtonConfig {
    let title: String
    let foregroundColor: Color
    let backgroundColor: Color
    let disabledBackgroundColor: Color
    let font: Font
    let height: CGFloat
    let cornerRadius: CGFloat
    let isLoading: Bool
    let action: () -> Void
}
