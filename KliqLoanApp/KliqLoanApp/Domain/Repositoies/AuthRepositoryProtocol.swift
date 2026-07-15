//
//  AuthRepositoryProtocol.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol AuthRepositoryProtocol {
    var isLoggedIn: Bool { get }

    func login(email: String, password: String) async throws
    func logout() async throws
}
