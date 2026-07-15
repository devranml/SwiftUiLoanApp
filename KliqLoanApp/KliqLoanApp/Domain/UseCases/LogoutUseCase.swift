//
//  LogoutUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol LogoutUseCaseProtocol {
    func execute() async throws
}

struct LogoutUseCase: LogoutUseCaseProtocol {
    private let repository: any AuthRepositoryProtocol

    init(repository: any AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws {
        try await repository.logout()
    }
}
