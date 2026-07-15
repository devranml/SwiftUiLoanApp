//
//  AutoLoanStrategyTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class AutoLoanStrategyTests: XCTestCase {
    private let strategy = AutoLoanStrategy()

    func test_activeLoanBeforeDueDate_increasesRateByPointFour() {
        var loan = Loan.fixture(
            interestRate: 4,
            status: .active,
            dueIn: 20,
            type: .auto
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            4.4,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .active)
    }

    func test_expiredActiveLoan_becomesOverdue() {
        var loan = Loan.fixture(
            interestRate: 4,
            status: .active,
            dueIn: 0,
            type: .auto
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            4.9,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanWithLowPrincipal_staysOverdue() {
        var loan = Loan.fixture(
            principalAmount: 40_000,
            interestRate: 4,
            status: .overdue,
            type: .auto
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            5.8,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanWithHighPrincipal_becomesDefault() {
        var loan = Loan.fixture(
            principalAmount: 60_000,
            interestRate: 4,
            status: .overdue,
            type: .auto
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            5.8,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .default)
    }
}
