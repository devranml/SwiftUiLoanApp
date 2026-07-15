//
//  Loan+Fixture.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import Foundation

extension Loan {
    static func fixture(
        name: String = "Test Loan",
        principalAmount: Double = 10_000,
        interestRate: Double = 5,
        status: LoanStatus = .active,
        dueIn: Int = 30,
        type: LoanType = .personal
    ) -> Loan {
        Loan(
            name: name,
            principalAmount: principalAmount,
            interestRate: interestRate,
            status: status,
            dueIn: dueIn,
            type: type
        )
    }
}
