//
//  SessionStorage.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

protocol SessionStoring {
    var isLoggedIn: Bool { get }

    func saveSession()
    func clearSession()
}

final class SessionStorage: SessionStoring {
    private enum Key {
        static let isLoggedIn = "is_logged_in"
    }

    private let defaults: UserDefaults

    init(
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
    }

    var isLoggedIn: Bool {
        defaults.bool(
            forKey: Key.isLoggedIn
        )
    }

    func saveSession() {
        defaults.set(
            true,
            forKey: Key.isLoggedIn
        )
    }

    func clearSession() {
        defaults.removeObject(
            forKey: Key.isLoggedIn
        )
    }
}
