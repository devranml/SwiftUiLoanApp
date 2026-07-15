//
//  MockLogoutUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp

final class MockLogoutUseCase: LogoutUseCaseProtocol {
    var errorToThrow: Error?
    private(set) var callCount = 0

    func execute() async throws {
        callCount += 1

        if let errorToThrow {
            throw errorToThrow
        }
    }
}
