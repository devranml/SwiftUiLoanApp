//
//  LoanFilter.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

enum LoanFilter: CaseIterable, Hashable {
    case all
    case active
    case overdue
    case `default`
    case paid

    var title: String {
        switch self {
        case .all:
            AppStrings.Filter.all

        case .active:
            AppStrings.Filter.active

        case .overdue:
            AppStrings.Filter.overdue

        case .default:
            AppStrings.Filter.defaultStatus

        case .paid:
            AppStrings.Filter.paid
        }
    }

    func matches(_ loan: Loan) -> Bool {
        switch self {
        case .all:
            true

        case .active:
            loan.status == .active

        case .overdue:
            loan.status == .overdue

        case .default:
            loan.status == .default

        case .paid:
            loan.status == .paid
        }
    }
}
