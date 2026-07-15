//
//  AuthRepository.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

final class AuthRepository: AuthRepositoryProtocol {
    private let service: any AuthServiceProtocol
    private let storage: any SessionStoring

    init(
        service: any AuthServiceProtocol,
        storage: any SessionStoring
    ) {
        self.service = service
        self.storage = storage
    }

    var isLoggedIn: Bool {
        storage.isLoggedIn
    }

    func login(email: String, password: String) async throws {
        try await service.login(email: email, password: password)
        storage.saveSession()
    }

    func logout() async throws {
        try await service.logout()
        storage.clearSession()
    }
}
