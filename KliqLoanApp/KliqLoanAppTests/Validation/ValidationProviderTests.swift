//
//  ValidationProviderTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

final class ValidationProviderTests: XCTestCase {
    private let provider = ValidationProvider()

    func test_emptyEmail_returnsRequiredErrorFirst() {
        let result = provider.validate(
            "",
            rules: [
                RequiredRule(),
                EmailRule()
            ]
        )

        XCTAssertEqual(
            result,
            AppStrings.Validation.required
        )
    }

    func test_invalidEmail_returnsEmailError() {
        let result = provider.validate(
            "invalid-email",
            rules: [
                RequiredRule(),
                EmailRule()
            ]
        )

        XCTAssertEqual(
            result,
            AppStrings.Validation.invalidEmail
        )
    }

    func test_validValue_returnsNil() {
        let result = provider.validate(
            "user@example.com",
            rules: [
                RequiredRule(),
                EmailRule()
            ]
        )

        XCTAssertNil(result)
    }
}
