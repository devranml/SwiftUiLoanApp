//
//  LoginViewModelTests.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp
import XCTest

@MainActor
final class LoginViewModelTests: XCTestCase {
    private var loginUseCase: MockLoginUseCase!
    private var loginSuccessCallCount: Int!
    private var sut: LoginViewModel!

    override func setUp() {
        super.setUp()

        loginUseCase = MockLoginUseCase()
        loginSuccessCallCount = 0

        sut = LoginViewModel(
            loginUseCase: loginUseCase,
            validationProvider: ValidationProvider(),
            onLoginSuccess: { [weak self] in
                self?.loginSuccessCallCount += 1
            }
        )
    }

    override func tearDown() {
        loginUseCase = nil
        sut = nil
        loginSuccessCallCount = nil

        super.tearDown()
    }

    func test_signIn_withEmptyFields_setsValidationErrors() async {
        await sut.signIn()

        XCTAssertEqual(
            sut.form.emailError,
            AppStrings.Validation.required
        )
        XCTAssertEqual(
            sut.form.passwordError,
            AppStrings.Validation.required
        )
        XCTAssertEqual(loginUseCase.callCount, 0)
        XCTAssertEqual(loginSuccessCallCount, 0)
    }

    func test_signIn_withInvalidEmail_doesNotCallUseCase() async {
        sut.form.email = "invalid-email"
        sut.form.password = "123456"

        await sut.signIn()

        XCTAssertEqual(
            sut.form.emailError,
            AppStrings.Validation.invalidEmail
        )
        XCTAssertEqual(loginUseCase.callCount, 0)
    }

    func test_signIn_withShortPassword_doesNotCallUseCase() async {
        sut.form.email = "user@example.com"
        sut.form.password = "123"

        await sut.signIn()

        XCTAssertEqual(
            sut.form.passwordError,
            AppStrings.Validation.minimumLength(6)
        )
        XCTAssertEqual(loginUseCase.callCount, 0)
    }

    func test_signIn_withValidForm_callsUseCase() async {
        sut.form.email = "user@example.com"
        sut.form.password = "123456"

        await sut.signIn()

        XCTAssertEqual(loginUseCase.callCount, 1)
        XCTAssertEqual(
            loginUseCase.receivedEmail,
            "user@example.com"
        )
        XCTAssertEqual(
            loginUseCase.receivedPassword,
            "123456"
        )
        XCTAssertEqual(loginSuccessCallCount, 1)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_signIn_whenUseCaseFails_setsErrorMessage() async {
        loginUseCase.errorToThrow = TestError.expected

        sut.form.email = "user@example.com"
        sut.form.password = "123456"

        await sut.signIn()

        XCTAssertEqual(loginUseCase.callCount, 1)
        XCTAssertEqual(loginSuccessCallCount, 0)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }
}
