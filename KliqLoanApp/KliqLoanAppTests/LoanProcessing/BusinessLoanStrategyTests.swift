//
//  BusinessLoanStrategyTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class BusinessLoanStrategyTests: XCTestCase {
    private let strategy = BusinessLoanStrategy()

    func test_activeLoanBeforeDueDate_increasesRateByPointFive() {
        var loan = Loan.fixture(
            interestRate: 4,
            status: .active,
            dueIn: 30,
            type: .business
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            4.5,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .active)
    }

    func test_expiredActiveLoan_becomesOverdue() {
        var loan = Loan.fixture(
            interestRate: 4,
            status: .active,
            dueIn: 0,
            type: .business
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            5,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanWithLowPrincipal_staysOverdue() {
        var loan = Loan.fixture(
            principalAmount: 90_000,
            interestRate: 4,
            status: .overdue,
            type: .business
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            6,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanWithHighPrincipal_becomesDefault() {
        var loan = Loan.fixture(
            principalAmount: 120_000,
            interestRate: 4,
            status: .overdue,
            type: .business
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            6,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .default)
    }
}
