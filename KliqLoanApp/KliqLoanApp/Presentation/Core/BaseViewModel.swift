//
//  BaseViewModel.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

@MainActor
class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?

    func onAppear() async {}

    func execute(_ operation: () async throws -> Void) async {
        guard !isLoading else {
            return
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            try await operation()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func showError(_ message: String) {
        errorMessage = message
    }

    func clearError() {
        errorMessage = nil
    }
}
