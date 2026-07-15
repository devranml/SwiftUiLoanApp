//
//  EmailRuleTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class EmailRuleTests: XCTestCase {
    private let rule = EmailRule()

    func test_validEmail_returnsNil() {
        let result = rule.validate("user@example.com")

        XCTAssertNil(result)
    }

    func test_emailWithoutAtSign_returnsError() {
        let result = rule.validate("userexample.com")

        XCTAssertEqual(
            result,
            AppStrings.Validation.invalidEmail
        )
    }

    func test_emailWithoutDomainExtension_returnsError() {
        let result = rule.validate("user@example")

        XCTAssertEqual(
            result,
            AppStrings.Validation.invalidEmail
        )
    }
}
