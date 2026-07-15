//
//  PersonalLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct PersonalLoanStrategy: LoanProcessingStrategy {
    let supportedType: LoanType = .personal

    func adjustInterest(
        for loan: inout Loan
    ) {
        switch loan.status {
        case .active where loan.dueIn > 0:
            loan.interestRate += 0.3

        case .active where loan.principalAmount > 10_000:
            loan.interestRate += 1.2
            loan.status = .overdue

        case .active:
            loan.interestRate += 0.6

        case .overdue:
            loan.interestRate += 1.5

            if loan.principalAmount > 20_000 {
                loan.status = .default
            }

        case .default, .paid:
            break
        }
    }
}
