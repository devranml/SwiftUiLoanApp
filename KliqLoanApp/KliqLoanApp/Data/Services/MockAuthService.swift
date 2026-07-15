//
//  MockAuthService.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

struct MockAuthService: AuthServiceProtocol {
    enum AuthError: LocalizedError {
        case invalidCredentials

        var errorDescription: String? {
            AppStrings.Auth.invalidCredentials
        }
    }
    func login(email: String, password: String) async throws {
        try await Task.sleep(
            for: .milliseconds(500)
        )

        guard email.contains("@"),
            password.count >= 6
        else {
            throw AuthError.invalidCredentials
        }
    }

    func logout() async throws {
        try await Task.sleep(
            for: .milliseconds(200)
        )
    }
}
