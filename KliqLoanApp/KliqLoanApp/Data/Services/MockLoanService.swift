//
//  MockLoanService.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

//MARK: MockAuthService
final class MockLoanService: LoanServiceProtocol {
    func fetchLoans() async throws -> [Loan] {
        guard
            let url = Bundle.main.url(
                forResource: "loans",
                withExtension: "json"
            )
        else {
            throw NSError(
                domain: "LoanServiceError",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Failed to find loans.json"
                ]
            )
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(
            [Loan].self,
            from: data
        )
    }

    func persistLoans(
        _ loans: [Loan]
    ) async throws {
        print("Persisted \(loans.count) loans")
    }
}
