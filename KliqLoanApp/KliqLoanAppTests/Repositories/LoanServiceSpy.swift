//
//  LoanServiceSpy.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp

final class LoanServiceSpy: LoanServiceProtocol {
    var loansToReturn: [Loan] = []
    var fetchError: Error?
    var persistError: Error?

    private(set) var fetchCallCount = 0
    private(set) var persistCallCount = 0
    private(set) var persistedLoans: [Loan] = []

    func fetchLoans() async throws -> [Loan] {
        fetchCallCount += 1

        if let fetchError {
            throw fetchError
        }

        return loansToReturn
    }

    func persistLoans(
        _ loans: [Loan]
    ) async throws {
        persistCallCount += 1

        if let persistError {
            throw persistError
        }

        persistedLoans = loans
    }
}
