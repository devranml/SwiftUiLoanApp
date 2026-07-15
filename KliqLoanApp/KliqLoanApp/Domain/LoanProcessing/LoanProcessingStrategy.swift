//
//  LoanProcessingStrategy.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol LoanProcessingStrategy {
    var supportedType: LoanType { get }

    func adjustInterest(
        for loan: inout Loan
    )
}
