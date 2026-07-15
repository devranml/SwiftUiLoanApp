//
//  RequiredRuleTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class RequiredRuleTests: XCTestCase {
    private let rule = RequiredRule()

    func test_emptyValue_returnsError() {
        let result = rule.validate("")

        XCTAssertEqual(
            result,
            AppStrings.Validation.required
        )
    }

    func test_whitespaceOnlyValue_returnsError() {
        let result = rule.validate("   ")

        XCTAssertEqual(
            result,
            AppStrings.Validation.required
        )
    }

    func test_nonEmptyValue_returnsNil() {
        let result = rule.validate("test")

        XCTAssertNil(result)
    }
}
