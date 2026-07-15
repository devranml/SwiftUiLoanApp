//
//  LoginViewModel.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

@MainActor
final class LoginViewModel: BaseViewModel {
    @Published var form = LoginFormState()

    private let loginUseCase: any LoginUseCaseProtocol
    private let validationProvider: any ValidationProviding
    private let onLoginSuccess: () -> Void

    init(
        loginUseCase: any LoginUseCaseProtocol,
        validationProvider: any ValidationProviding,
        onLoginSuccess: @escaping () -> Void
    ) {
        self.loginUseCase = loginUseCase
        self.validationProvider = validationProvider
        self.onLoginSuccess = onLoginSuccess
    }

    var isLoginEnabled: Bool {
        !form.email.isEmpty &&
        !form.password.isEmpty &&
        !isLoading
    }

    func validateEmail() {
        form.emailError = validationProvider.validate(
            form.email,
            rules: [
                RequiredRule(),
                EmailRule()
            ]
        )
    }

    func validatePassword() {
        form.passwordError = validationProvider.validate(
            form.password,
            rules: [
                RequiredRule(),
                MinimumLengthRule(
                    minimumLength: 6
                )
            ]
        )
    }

    func signIn() async {
        validateEmail()
        validatePassword()

        guard form.emailError == nil,
              form.passwordError == nil else {
            return
        }

        await execute {
            try await self.loginUseCase.execute(
                email: self.form.email,
                password: self.form.password
            )

            self.onLoginSuccess()
        }
    }
}
