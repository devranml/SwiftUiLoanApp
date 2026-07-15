//
//  MockLoginUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

@testable import KliqLoanApp

final class MockLoginUseCase: LoginUseCaseProtocol {
    var errorToThrow: Error?

    private(set) var callCount = 0
    private(set) var receivedEmail: String?
    private(set) var receivedPassword: String?

    func execute(
        email: String,
        password: String
    ) async throws {
        callCount += 1
        receivedEmail = email
        receivedPassword = password

        if let errorToThrow {
            throw errorToThrow
        }
    }
}
