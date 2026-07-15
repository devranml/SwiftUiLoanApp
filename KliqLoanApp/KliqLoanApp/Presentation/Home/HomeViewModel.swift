//
//  HomeViewModel.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

@MainActor
final class HomeViewModel: BaseViewModel {
    @Published var loans: [Loan] = []
    @Published var selectedFilter: LoanFilter = .all

    private let updateLoansUseCase:
        any UpdateLoansUseCaseProtocol

    private let logoutUseCase:
        any LogoutUseCaseProtocol

    private let onLogoutSuccess: () -> Void

    init(
        updateLoansUseCase:
            any UpdateLoansUseCaseProtocol,
        logoutUseCase:
            any LogoutUseCaseProtocol,
        onLogoutSuccess: @escaping () -> Void
    ) {
        self.updateLoansUseCase =
            updateLoansUseCase

        self.logoutUseCase =
            logoutUseCase

        self.onLogoutSuccess =
            onLogoutSuccess
    }

    override func onAppear() async {
        guard loans.isEmpty else {
            return
        }

        await loadLoans()
    }

    var filteredLoans: [Loan] {
        loans.filter(
            selectedFilter.matches
        )
    }

    var totalAmount: Double {
        filteredLoans.reduce(0) {
            $0 + $1.principalAmount
        }
    }

    var averageRate: Double {
        guard !filteredLoans.isEmpty else {
            return 0
        }

        let totalRate = filteredLoans.reduce(0) {
            $0 + $1.interestRate
        }

        return totalRate /
            Double(filteredLoans.count)
    }

    var totalAmountText: String {
        totalAmount.formatted(
            .currency(
                code: "USD"
            )
            .precision(
                .fractionLength(0)
            )
        )
    }

    var loanCountText: String {
        AppStrings.Home.loanCount(
            filteredLoans.count
        )
    }

    var averageRateText: String {
        AppStrings.Home.averageRate(
            averageRate
        )
    }

    func loadLoans() async {
        await execute {
            self.loans =
                try await self
                    .updateLoansUseCase
                    .execute()
        }
    }

    func logout() async {
        await execute {
            try await self.logoutUseCase.execute()
            self.onLogoutSuccess()
        }
    }
}
