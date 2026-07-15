//
//  PersonalLoanStrategyTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class PersonalLoanStrategyTests: XCTestCase {
    private let strategy = PersonalLoanStrategy()

    func test_activeLoanBeforeDueDate_increasesRateByPointThree() {
        var loan = Loan.fixture(
            interestRate: 5,
            status: .active,
            dueIn: 10,
            type: .personal
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            5.3,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .active)
    }

    func test_expiredActiveLoanWithLowPrincipal_increasesRateByPointSix() {
        var loan = Loan.fixture(
            principalAmount: 8_000,
            interestRate: 5,
            status: .active,
            dueIn: 0,
            type: .personal
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            5.6,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .active)
    }

    func test_expiredActiveLoanWithHighPrincipal_becomesOverdue() {
        var loan = Loan.fixture(
            principalAmount: 15_000,
            interestRate: 5,
            status: .active,
            dueIn: 0,
            type: .personal
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            6.2,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanWithLowPrincipal_increasesRateByOnePointFive() {
        var loan = Loan.fixture(
            principalAmount: 15_000,
            interestRate: 5,
            status: .overdue,
            type: .personal
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            6.5,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanWithHighPrincipal_becomesDefault() {
        var loan = Loan.fixture(
            principalAmount: 25_000,
            interestRate: 5,
            status: .overdue,
            type: .personal
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            6.5,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .default)
    }

    func test_paidLoan_doesNotChange() {
        var loan = Loan.fixture(
            interestRate: 5,
            status: .paid,
            type: .personal
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(loan.interestRate, 5)
        XCTAssertEqual(loan.status, .paid)
    }
}
