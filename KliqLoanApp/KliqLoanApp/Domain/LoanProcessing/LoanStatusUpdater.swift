//
//  LoanStatusUpdater.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol LoanStatusUpdating {
    func update(
        _ loan: inout Loan
    )
}

struct LoanStatusUpdater: LoanStatusUpdating {
    func update(
        _ loan: inout Loan
    ) {
        if loan.dueIn < -90,
           loan.status != .paid {
            loan.status = .default
        }

        if loan.principalAmount <= 0 {
            loan.status = .paid
        }
    }
}
