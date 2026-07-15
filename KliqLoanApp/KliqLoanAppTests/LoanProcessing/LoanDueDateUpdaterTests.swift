//
//  LoanDueDateUpdaterTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class LoanDueDateUpdaterTests: XCTestCase {
    private let updater = LoanDueDateUpdater()

    func test_positiveDueDate_decreasesByOne() {
        var loan = Loan.fixture(dueIn: 10)

        updater.update(&loan)

        XCTAssertEqual(loan.dueIn, 9)
    }

    func test_zeroDueDate_becomesMinusOne() {
        var loan = Loan.fixture(dueIn: 0)

        updater.update(&loan)

        XCTAssertEqual(loan.dueIn, -1)
    }

    func test_negativeDueDate_decreasesByOne() {
        var loan = Loan.fixture(dueIn: -10)

        updater.update(&loan)

        XCTAssertEqual(loan.dueIn, -11)
    }
}
