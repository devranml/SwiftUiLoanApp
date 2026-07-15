//
//  MortgageLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct MortgageLoanStrategy: LoanProcessingStrategy {
    let supportedType: LoanType = .mortgage

    func adjustInterest(
        for loan: inout Loan
    ) {
        switch loan.status {
        case .active where loan.dueIn > 0:
            loan.interestRate += 0.1

        case .active:
            loan.interestRate += 0.4
            loan.status = .overdue

        case .overdue:
            loan.interestRate += 0.8

            if loan.dueIn < -60 {
                loan.status = .default
            }

        case .default, .paid:
            break
        }
    }
}
