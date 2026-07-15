//
//  MockLoanRepository.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp

final class MockLoanRepository: LoanRepositoryProtocol {
    var loansToReturn: [Loan] = []
    var fetchError: Error?
    var saveError: Error?

    private(set) var fetchCallCount = 0
    private(set) var saveCallCount = 0
    private(set) var savedLoans: [Loan] = []

    func fetchLoans() async throws -> [Loan] {
        fetchCallCount += 1

        if let fetchError {
            throw fetchError
        }

        return loansToReturn
    }

    func saveLoans(_ loans: [Loan]) async throws {
        saveCallCount += 1

        if let saveError {
            throw saveError
        }

        savedLoans = loans
    }
}
