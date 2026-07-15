//
//  CheckSessionUseCase.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol CheckSessionUseCaseProtocol {
    func execute() -> Bool
}

struct CheckSessionUseCase: CheckSessionUseCaseProtocol {
    private let repository: any AuthRepositoryProtocol

    init(repository: any AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> Bool {
        repository.isLoggedIn
    }
}
