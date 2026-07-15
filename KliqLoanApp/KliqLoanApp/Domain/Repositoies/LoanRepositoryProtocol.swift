//
//  LoanRepositoryProtocol.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol LoanRepositoryProtocol {
    func fetchLoans() async throws -> [Loan]

    func saveLoans(
        _ loans: [Loan]
    ) async throws
}
