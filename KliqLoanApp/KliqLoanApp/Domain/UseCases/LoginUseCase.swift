//
//  LoginUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws
}

struct LoginUseCase: LoginUseCaseProtocol {
    private let repository: any AuthRepositoryProtocol

    init(repository: any AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute(email: String,password: String) async throws {
        try await repository.login(email: email, password: password)
    }
}
