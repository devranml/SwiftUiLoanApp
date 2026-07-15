//
//  LoanDueDateUpdater.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol LoanDueDateUpdating {
    func update(
        _ loan: inout Loan
    )
}

struct LoanDueDateUpdater: LoanDueDateUpdating {
    func update(
        _ loan: inout Loan
    ) {
        loan.dueIn -= 1
    }
}
