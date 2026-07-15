//
//  LoanRepositoryTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class LoanRepositoryTests: XCTestCase {
    func test_fetchLoans_returnsServiceLoans() async throws {
        let service = LoanServiceSpy()

        service.loansToReturn = [
            Loan.fixture(name: "Loan A")
        ]

        let repository = LoanRepository(
            service: service
        )

        let result = try await repository.fetchLoans()

        XCTAssertEqual(service.fetchCallCount, 1)
        XCTAssertEqual(result, service.loansToReturn)
    }

    func test_saveLoans_passesLoansToService() async throws {
        let service = LoanServiceSpy()
        let repository = LoanRepository(
            service: service
        )

        let loans = [
            Loan.fixture(name: "Loan A")
        ]

        try await repository.saveLoans(loans)

        XCTAssertEqual(service.persistCallCount, 1)
        XCTAssertEqual(service.persistedLoans, loans)
    }

    func test_fetchLoans_whenServiceFails_throws() async {
        let service = LoanServiceSpy()
        service.fetchError = TestError.expected

        let repository = LoanRepository(
            service: service
        )

        do {
            _ = try await repository.fetchLoans()
            XCTFail("Expected repository to throw")
        } catch {
            XCTAssertEqual(service.fetchCallCount, 1)
        }
    }
}
