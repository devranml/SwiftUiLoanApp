//
//  AutoLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct AutoLoanStrategy: LoanProcessingStrategy {
    let supportedType: LoanType = .auto

    func adjustInterest(
        for loan: inout Loan
    ) {
        switch loan.status {
        case .active where loan.dueIn > 0:
            loan.interestRate += 0.4

        case .active:
            loan.interestRate += 0.9
            loan.status = .overdue

        case .overdue:
            loan.interestRate += 1.8

            if loan.principalAmount > 50_000 {
                loan.status = .default
            }

        case .default, .paid:
            break
        }
    }
}
