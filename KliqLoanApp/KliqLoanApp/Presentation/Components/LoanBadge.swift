//
//  Untitled.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct LoanBadge: View {
    let title: String
    let color: Color
    let fonts: any FontProviding

    var body: some View {
        Text(title.uppercased())
            .font(fonts.badge)
            .foregroundStyle(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(color)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 4
                )
            )
    }
}
