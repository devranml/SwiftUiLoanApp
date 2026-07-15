//
//  LoanCard.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct LoanCard: View {
    let loan: Loan
    let colors: any ColorProviding
    let fonts: any FontProviding

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            HStack(spacing: 8) {
                Text(loan.name)
                    .font(fonts.body.bold())
                    .foregroundStyle(
                        colors.textPrimary
                    )

                LoanBadge(
                    title: loan.type.rawValue,
                    color: colors.typeColor(
                        for: loan.type
                    ),
                    fonts: fonts
                )

                Spacer()

                LoanBadge(
                    title: loan.status.rawValue,
                    color: colors.statusColor(
                        for: loan.status
                    ),
                    fonts: fonts
                )
            }

            HStack(spacing: 12) {
                Text(
                    loan.principalAmount.formatted(
                        .currency(code: "USD")
                        .precision(
                            .fractionLength(0)
                        )
                    )
                )
                .font(fonts.amount)
                .foregroundStyle(
                    colors.textPrimary
                )

                Text(
                    AppStrings.Home.interestRate(
                        loan.interestRate
                    )
                )
                .font(fonts.caption)
                .foregroundStyle(
                    colors.textSecondary
                )
            }

            Text(dueDateText)
                .font(fonts.caption)
                .foregroundStyle(dueDateColor)
        }
        .padding(16)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(
            colors.cardBackground
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 12
            )
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 6,
            y: 2
        )
    }

    private var dueDateText: String {
        if loan.dueIn > 0 {
            return AppStrings.Home.remainingDays(
                loan.dueIn
            )
        }

        if loan.dueIn == 0 {
            return AppStrings.Home.dueToday
        }

        return AppStrings.Home.overdueDays(
            abs(loan.dueIn)
        )
    }

    private var dueDateColor: Color {
        if loan.dueIn > 0 {
            return colors.success
        }

        if loan.dueIn == 0 {
            return colors.statusColor(
                for: .overdue
            )
        }

        return colors.statusColor(
            for: .default
        )
    }
}
