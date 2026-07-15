//
//  MortgageLoanStrategyTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class MortgageLoanStrategyTests: XCTestCase {
    private let strategy = MortgageLoanStrategy()

    func test_activeLoanBeforeDueDate_increasesRateByPointOne() {
        var loan = Loan.fixture(
            interestRate: 3,
            status: .active,
            dueIn: 20,
            type: .mortgage
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            3.1,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .active)
    }

    func test_expiredActiveLoan_becomesOverdue() {
        var loan = Loan.fixture(
            interestRate: 3,
            status: .active,
            dueIn: 0,
            type: .mortgage
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            3.4,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanBeforeSixtyDays_staysOverdue() {
        var loan = Loan.fixture(
            interestRate: 3,
            status: .overdue,
            dueIn: -30,
            type: .mortgage
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            3.8,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .overdue)
    }

    func test_overdueLoanAfterSixtyDays_becomesDefault() {
        var loan = Loan.fixture(
            interestRate: 3,
            status: .overdue,
            dueIn: -61,
            type: .mortgage
        )

        strategy.adjustInterest(for: &loan)

        XCTAssertEqual(
            loan.interestRate,
            3.8,
            accuracy: 0.0001
        )
        XCTAssertEqual(loan.status, .default)
    }
}
