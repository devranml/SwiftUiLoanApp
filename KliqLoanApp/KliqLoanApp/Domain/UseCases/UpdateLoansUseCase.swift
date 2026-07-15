//
//  UpdateLoansUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol UpdateLoansUseCaseProtocol {
    func execute() async throws -> [Loan]
}

struct UpdateLoansUseCase: UpdateLoansUseCaseProtocol {
    private let repository: any LoanRepositoryProtocol
    private let strategyRegistry: LoanStrategyRegistry
    private let dueDateUpdater: any LoanDueDateUpdating
    private let statusUpdater: any LoanStatusUpdating

    init(
        repository: any LoanRepositoryProtocol,
        strategyRegistry: LoanStrategyRegistry,
        dueDateUpdater: any LoanDueDateUpdating,
        statusUpdater: any LoanStatusUpdating
    ) {
        self.repository = repository
        self.strategyRegistry = strategyRegistry
        self.dueDateUpdater = dueDateUpdater
        self.statusUpdater = statusUpdater
    }

    func execute() async throws -> [Loan] {
        var loans = try await repository.fetchLoans()

        for index in loans.indices {
            let strategy = try strategyRegistry.strategy(for: loans[index].type)

            strategy.adjustInterest(for: &loans[index])
            dueDateUpdater.update(&loans[index])
            statusUpdater.update(&loans[index])
        }

        try await repository.saveLoans(loans)
        return loans
    }
}
