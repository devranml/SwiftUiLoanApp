//
//  MinimumLengthRuleTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class MinimumLengthRuleTests: XCTestCase {
    private let rule = MinimumLengthRule(
        minimumLength: 6
    )

    func test_shortValue_returnsError() {
        let result = rule.validate("12345")

        XCTAssertEqual(
            result,
            AppStrings.Validation.minimumLength(6)
        )
    }

    func test_valueAtMinimumLength_returnsNil() {
        let result = rule.validate("123456")

        XCTAssertNil(result)
    }

    func test_longerValue_returnsNil() {
        let result = rule.validate("123456789")

        XCTAssertNil(result)
    }
}
