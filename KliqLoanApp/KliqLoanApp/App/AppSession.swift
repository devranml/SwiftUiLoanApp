//
//  AppSession.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

enum SessionState {
    case checking
    case authenticated
    case unauthenticated
}

@MainActor
final class AppSession: ObservableObject {
    @Published var state:
        SessionState = .checking

    private let checkSessionUseCase:
        any CheckSessionUseCaseProtocol

    init(
        checkSessionUseCase:
            any CheckSessionUseCaseProtocol
    ) {
        self.checkSessionUseCase =
            checkSessionUseCase
    }

    func checkSession() {
        state = checkSessionUseCase.execute()
            ? .authenticated
            : .unauthenticated
    }

    func loginCompleted() {
        state = .authenticated
    }

    func logoutCompleted() {
        state = .unauthenticated
    }
}
