//
//  AppStrings.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

enum AppStrings {
    enum Login {
        static let navigationTitle = String(localized: "login.navigation.title")
        static let emailTitle = String(localized: "login.email.title")
        static let emailPlaceholder = String(localized: "login.email.placeholder")
        static let passwordTitle = String(localized: "login.password.title")
        static let passwordPlaceholder = String(localized: "login.password.placeholder")
        static let signIn = String(localized: "login.button.sign_in")
    }

    enum Home {
        static let navigationTitle = String(localized: "home.navigation.title")
        static let logout = String(localized: "home.button.logout")
        static let emptyTitle = String(localized: "home.empty.title")

        static let emptyDescription = String(
            localized: "home.empty.description"
        )

        static let loading = String(
            localized: "home.loading"
        )

        static func loanCount(_ count: Int) -> String {
            String(
                format: String(
                    localized: "home.summary.loan_count"
                ),
                count
            )
        }

        static func averageRate(_ rate: Double) -> String {
            String(
                format: String(
                    localized: "home.summary.average_rate"
                ),
                rate
            )
        }

        static func remainingDays(_ days: Int) -> String {
            String(
                format: String(
                    localized: "home.loan.remaining_days"
                ),
                days
            )
        }

        static let dueToday = String(
            localized: "home.loan.due_today"
        )

        static func overdueDays(_ days: Int) -> String {
            String(
                format: String(
                    localized: "home.loan.overdue_days"
                ),
                days
            )
        }

        static func interestRate(_ rate: Double) -> String {
            String(
                format: String(
                    localized: "home.loan.interest"
                ),
                rate
            )
        }
    }

    enum Filter {
        static let all = String(localized: "filter.all")
        static let active = String(localized: "filter.active")
        static let overdue = String(localized: "filter.overdue")
        static let defaultStatus = String(localized: "filter.default")
        static let paid = String(localized: "filter.paid")
    }

    enum Validation {
        static let required = String(
            localized: "validation.required"
        )

        static let invalidEmail = String(
            localized: "validation.invalid_email"
        )

        static func minimumLength(_ length: Int) -> String {
            String(
                format: String(
                    localized: "validation.minimum_length"
                ),
                length
            )
        }
    }

    enum Error {
        static let title = String(
            localized: "error.title"
        )

        static let ok = String(
            localized: "common.ok"
        )

        static let unsupportedLoanType = String(
            localized: "error.unsupported_loan_type"
        )
    }
    
    enum Auth {
        static let invalidCredentials = String(localized:"auth.invalid_credentials")
    }
}
