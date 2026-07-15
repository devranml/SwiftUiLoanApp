//
//  ColorProvider.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

protocol ColorProviding {
    var primary: Color { get }
    var background: Color { get }
    var cardBackground: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var border: Color { get }
    var error: Color { get }
    var success: Color { get }

    func statusColor(
        for status: LoanStatus
    ) -> Color

    func typeColor(
        for type: LoanType
    ) -> Color
}

struct AppColorProvider: ColorProviding {
    let primary = Color(red: 0.13, green: 0.17, blue: 0.27)
    let background = Color(red: 0.95, green: 0.95, blue: 0.97)
    let cardBackground = Color.white

    let textPrimary = Color(red: 0.15, green: 0.15, blue: 0.20)
    let textSecondary = Color.gray

    let border = Color.gray.opacity(0.4)
    let error = Color.red

    let success = Color(red: 0.18, green: 0.72, blue: 0.45)

    func statusColor(
        for status: LoanStatus
    ) -> Color {
        switch status {
        case .active:
            success

        case .overdue: Color(red: 0.95, green: 0.62, blue: 0.15)

        case .default: Color(red: 0.90, green: 0.22, blue: 0.21)

        case .paid: Color(red: 0.55, green: 0.55, blue: 0.58)
        }
    }

    func typeColor(
        for type: LoanType
    ) -> Color {
        switch type {
        case .personal:
            primary

        case .mortgage:
            Color(red: 0.16, green: 0.50, blue: 0.73)

        case .auto: Color(red: 0.20, green: 0.60, blue: 0.56)

        case .business: Color(red: 0.58, green: 0.34, blue: 0.14)
        }
    }
}
