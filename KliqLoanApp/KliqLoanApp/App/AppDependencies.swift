//
//  AppDependencies.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct AppDependencies {
    let colors: any ColorProviding
    let fonts: any FontProviding

    private let authRepository: any AuthRepositoryProtocol

    private let updateLoansUseCase: any UpdateLoansUseCaseProtocol

    init() {
        colors = AppColorProvider()
        fonts = AppFontProvider()

        let sessionStorage = SessionStorage()
        let authService = MockAuthService()

        authRepository = AuthRepository(
            service: authService,
            storage: sessionStorage
        )

        let loanService = MockLoanService()

        let loanRepository = LoanRepository(
            service: loanService as LoanServiceProtocol
        )

        let strategyRegistry =
            LoanStrategyRegistry(
                strategies: [
                    PersonalLoanStrategy(),
                    MortgageLoanStrategy(),
                    AutoLoanStrategy(),
                    BusinessLoanStrategy(),
                ]
            )

        updateLoansUseCase = UpdateLoansUseCase(
            repository: loanRepository,
            strategyRegistry:
                strategyRegistry,
            dueDateUpdater:
                LoanDueDateUpdater(),
            statusUpdater:
                LoanStatusUpdater()
        )
    }
    @MainActor
    func makeAppSession() -> AppSession {
        AppSession(
            checkSessionUseCase:
                CheckSessionUseCase(
                    repository: authRepository
                )
        )
    }
    @MainActor
    func makeLoginViewModel(onLoginSuccess: @escaping () -> Void)
        -> LoginViewModel
    {
        LoginViewModel(
            loginUseCase: LoginUseCase(
                repository: authRepository
            ),
            validationProvider:
                ValidationProvider(),
            onLoginSuccess: onLoginSuccess
        )
    }

    @MainActor
    func makeHomeViewModel(onLogoutSuccess: @escaping () -> Void)
        -> HomeViewModel
    {
        HomeViewModel(
            updateLoansUseCase:
                updateLoansUseCase,
            logoutUseCase: LogoutUseCase(
                repository: authRepository
            ),
            onLogoutSuccess:
                onLogoutSuccess
        )
    }

    func isSessionActive() -> Bool {
        CheckSessionUseCase(
            repository: authRepository
        ).execute()
    }
}
