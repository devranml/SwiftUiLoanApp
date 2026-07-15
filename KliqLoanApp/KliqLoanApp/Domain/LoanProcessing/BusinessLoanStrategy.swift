//
//  BusinessLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct BusinessLoanStrategy: LoanProcessingStrategy {
    let supportedType: LoanType = .business

    func adjustInterest(
        for loan: inout Loan
    ) {
        switch loan.status {
        case .active where loan.dueIn > 0:
            loan.interestRate += 0.5

        case .active:
            loan.interestRate += 1.0
            loan.status = .overdue

        case .overdue:
            loan.interestRate += 2.0

            if loan.principalAmount > 100_000 {
                loan.status = .default
            }

        case .default, .paid:
            break
        }
    }
}
