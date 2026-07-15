//
//  LoanServiceProtocol.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

//MARK: - LoanServiceProtocol
protocol LoanServiceProtocol {
    func fetchLoans() async throws -> [Loan]
    func persistLoans(_ loans: [Loan]) async throws
}
