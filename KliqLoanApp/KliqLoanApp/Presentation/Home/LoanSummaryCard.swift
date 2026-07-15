//
//  LoanSummaryCard.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//
import SwiftUI

struct LoanSummaryCard: View {
    let totalAmount: String
    let countText: String
    let averageRateText: String

    let colors: any ColorProviding
    let fonts: any FontProviding

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text(totalAmount)
                .font(fonts.heading)
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 4) {

                Text(countText)
                    .font(fonts.body)
                    .foregroundStyle(.white.opacity(0.9))

                Text(averageRateText)
                    .font(fonts.caption)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(colors.primary)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}
