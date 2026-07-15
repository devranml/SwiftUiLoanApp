//
//  LoanRepository.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

final class LoanRepository: LoanRepositoryProtocol {
    private let service: any LoanServiceProtocol

    init(service: any LoanServiceProtocol) {
        self.service = service
    }

    func fetchLoans() async throws -> [Loan] {
        try await service.fetchLoans()
    }

    func saveLoans(_ loans: [Loan]) async throws {
        try await service.persistLoans(loans)
    }
}
