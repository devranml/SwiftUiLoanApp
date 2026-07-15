//
//  MockUpdateLoansUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp

final class MockUpdateLoansUseCase:
    UpdateLoansUseCaseProtocol {

    var loansToReturn: [Loan] = []
    var errorToThrow: Error?

    private(set) var callCount = 0

    func execute() async throws -> [Loan] {
        callCount += 1

        if let errorToThrow {
            throw errorToThrow
        }

        return loansToReturn
    }
}
