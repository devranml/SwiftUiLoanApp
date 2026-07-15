//
//  LoanStatusUpdaterTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class LoanStatusUpdaterTests: XCTestCase {
    private let updater = LoanStatusUpdater()

    func test_dueDateBelowMinusNinety_setsDefault() {
        var loan = Loan.fixture(
            principalAmount: 10_000,
            status: .overdue,
            dueIn: -91
        )

        updater.update(&loan)

        XCTAssertEqual(loan.status, .default)
    }

    func test_paidLoanBelowMinusNinety_staysPaid() {
        var loan = Loan.fixture(
            principalAmount: 10_000,
            status: .paid,
            dueIn: -91
        )

        updater.update(&loan)

        XCTAssertEqual(loan.status, .paid)
    }

    func test_zeroPrincipal_setsPaid() {
        var loan = Loan.fixture(
            principalAmount: 0,
            status: .default,
            dueIn: -100
        )

        updater.update(&loan)

        XCTAssertEqual(loan.status, .paid)
    }

    func test_negativePrincipal_setsPaid() {
        var loan = Loan.fixture(
            principalAmount: -100,
            status: .active
        )

        updater.update(&loan)

        XCTAssertEqual(loan.status, .paid)
    }
}
