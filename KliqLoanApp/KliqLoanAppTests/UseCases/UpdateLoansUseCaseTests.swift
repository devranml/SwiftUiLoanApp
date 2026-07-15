//
//  UpdateLoansUseCaseTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class UpdateLoansUseCaseTests: XCTestCase {
    private var repository: MockLoanRepository!
    private var sut: UpdateLoansUseCase!

    override func setUp() {
        super.setUp()

        repository = MockLoanRepository()

        let registry = LoanStrategyRegistry(
            strategies: [
                PersonalLoanStrategy(),
                MortgageLoanStrategy(),
                AutoLoanStrategy(),
                BusinessLoanStrategy()
            ]
        )

        sut = UpdateLoansUseCase(
            repository: repository,
            strategyRegistry: registry,
            dueDateUpdater: LoanDueDateUpdater(),
            statusUpdater: LoanStatusUpdater()
        )
    }

    override func tearDown() {
        repository = nil
        sut = nil

        super.tearDown()
    }

    func test_execute_fetchesProcessesAndSavesLoans() async throws {
        repository.loansToReturn = [
            Loan.fixture(
                interestRate: 5,
                status: .active,
                dueIn: 10,
                type: .personal
            )
        ]

        let result = try await sut.execute()

        XCTAssertEqual(repository.fetchCallCount, 1)
        XCTAssertEqual(repository.saveCallCount, 1)
        XCTAssertEqual(result.count, 1)

        XCTAssertEqual(
            result[0].interestRate,
            5.3,
            accuracy: 0.0001
        )
        XCTAssertEqual(result[0].dueIn, 9)
        XCTAssertEqual(repository.savedLoans, result)
    }

    func test_execute_whenFetchFails_doesNotSave() async {
        repository.fetchError = TestError.expected

        do {
            _ = try await sut.execute()
            XCTFail("Expected execute to throw")
        } catch {
            XCTAssertEqual(repository.fetchCallCount, 1)
            XCTAssertEqual(repository.saveCallCount, 0)
        }
    }

    func test_execute_whenSaveFails_throwsError() async {
        repository.loansToReturn = [
            Loan.fixture()
        ]
        repository.saveError = TestError.expected

        do {
            _ = try await sut.execute()
            XCTFail("Expected save error")
        } catch {
            XCTAssertEqual(repository.fetchCallCount, 1)
            XCTAssertEqual(repository.saveCallCount, 1)
        }
    }
}
